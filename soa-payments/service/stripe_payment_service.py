import pybreaker
import stripe
from sqlalchemy.orm import Session

from circuitbreaker.CircuitBreakerListener import CircuitBreakerListener
from creds import mail_email
from dto.dtos import PaymentDTO
from receipt_crawler.crawl import crawl
from repo.crud import get_order_by_id, add_available_license_for_user, get_subscription_by_id
from repo.repo_models import Order

payment_breaker = pybreaker.CircuitBreaker(fail_max=2, reset_timeout=10, listeners=[CircuitBreakerListener()])


def after_pay(db: Session, order: Order):
    order.paid = True
    db.add(order)
    db.commit()
    db.refresh(order)
    subscription = get_subscription_by_id(db=db, sub_id=order.subscription_id)
    [add_available_license_for_user(db=db, user_id=order.user_id, months=subscription.months) for i in
     range(0, order.licenses_count)]



@payment_breaker
def execute_payment(paymentDto: PaymentDTO, db: Session, email: str = mail_email):
    order = get_order_by_id(db, paymentDto.orderId)
    if paymentDto.paymentMethodId is not None:
        # Create new PaymentIntent with a PaymentMethod ID from the client.

        intent = stripe.PaymentIntent.create(
            amount=int(order.amount_paid * 100),
            currency=paymentDto.currency,
            payment_method=paymentDto.paymentMethodId,
            confirmation_method='manual',
            # If a mobile client passes `useStripeSdk`, set `use_stripe_sdk=true`
            # to take advantage of new authentication features in mobile SDKs.
            use_stripe_sdk=True if 'useStripeSdk' in paymentDto and paymentDto.useStripeSdk else None,
        )

        intent = stripe.PaymentIntent.confirm(
            intent.id,
            payment_method="pm_card_visa",
            receipt_email=mail_email
        )
        after_pay(db, order)
        receipt_url = intent.charges.data[0].receipt_url
        crawl(receipt_url, email)
        # After create, if the PaymentIntent's status is succeeded, fulfill the order.
    elif paymentDto.paymentIntentId is not None:
        # Confirm the PaymentIntent to finalize payment after handling a required action
        # on the client.
        intent = stripe.PaymentIntent.confirm(paymentDto.paymentIntentId)

        # After confirm, if the PaymentIntent's status is succeeded, fulfill the order.
    return intent
