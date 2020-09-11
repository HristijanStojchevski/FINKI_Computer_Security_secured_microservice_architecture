import os

import stripe
from dotenv import load_dotenv, find_dotenv
from fastapi import APIRouter, Header, Depends
from requests import Session

from circuitbreaker.cb_call import circuitbreaker_call
from dto.dtos import PaymentDTO
from repo.database import get_db
from service.http_client_requests import fetch_user_email
from service.stripe_payment_service import execute_payment
from service.stripe_payment_service import payment_breaker

load_dotenv(find_dotenv())
stripe.api_key = "rk_test_{0}".format(os.getenv("SRK")[3:][::-1])

stripe_router = APIRouter()

@stripe_router.get('/stripe-key', summary="Gets the public stripe api key")
def fetch_key():
    # Send publishable key to client
    return circuitbreaker_call(payment_breaker, {'publishableKey': "pk_test_{0}".format(os.getenv("SPK")[3:][::-1]) })


@stripe_router.post('/pay', summary="Executes the payment")
def pay(paymentDto: PaymentDTO, x_access_token = Header(None), db: Session = Depends(get_db)):

    try:
        user_email = fetch_user_email(x_access_token)
        print(user_email)
        intent = execute_payment(paymentDto, email = user_email, db=db)
        response = generate_response(intent)
        return response
    except stripe.error.CardError as e:
        print('error')
        return {'error': e.user_message}


def generate_response(intent):
    status = intent['status']
    print(status)
    if status == 'requires_action' or status == 'requires_source_action':
        # Card requires authentication
        return {'requiresAction': True, 'paymentIntentId': intent['id'], 'clientSecret': intent['client_secret']}
    elif status == 'requires_payment_method' or status == 'requires_source':
        # Card was not properly authenticated, suggest a new payment method
        return {'error': 'Your card was denied, please provide a new payment method'}
    elif status == 'succeeded':
        # Payment is complete, authentication not required
        # To cancel the payment you will need to issue a Refund (https://stripe.com/docs/api/refunds)
        print("💰 Payment received!")
        return {'clientSecret': intent['client_secret']}
