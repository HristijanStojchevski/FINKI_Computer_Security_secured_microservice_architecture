from datetime import datetime

import requests
from sqlalchemy.orm import Session

from dto.dtos import OrderRequestDTO
from endpoints_config import referrals_get_package_by_id, referrals_get_credits_and_codes, \
    referrals_get_promo_code_by_id, referrals_post_successful_payment
from repo.crud import get_subscription_by_id, create_order
from service.domain_models import Package, PromoCode
from service.stripe_payment_service import after_pay


def get_promo_code(order_request_dto: OrderRequestDTO):
    promo_code_request = requests.get(referrals_get_promo_code_by_id.format(code_id=order_request_dto.promo_code))
    date_format = "%Y-%m-%dT%H:%M:%S"
    promo_code = promo_code_request.json()
    promo_code['startDate'] = datetime.strptime(promo_code['startDate'], date_format)
    promo_code['endDate'] = datetime.strptime(promo_code['endDate'], date_format)
    promo_code = PromoCode(**promo_code)
    if promo_code.startDate < datetime.today() < promo_code.endDate and promo_code.userID == order_request_dto.user_id and not promo_code.isUsed:
        return promo_code.discountPercentage
    else:
        return None


def create_and_save_order(db: Session, order_request_dto: OrderRequestDTO):
    print("Saving order")
    discount = 0
    if order_request_dto.promo_code:
        discount = get_promo_code(order_request_dto)
        if not discount:
            return None, 'Discount code not valid'
    discount = 0 if not discount else discount

    package_request = requests.get(referrals_get_credits_and_codes.format(user_id=order_request_dto.user_id))
    credits_available = package_request.json()['credits']
    print('User has {0} credits'.format(credits_available))
    package_request = requests.get(referrals_get_package_by_id.format(plan_id=order_request_dto.package_id))
    package = Package(**package_request.json())
    subscription = get_subscription_by_id(db=db, sub_id=order_request_dto.subscription_id)
    amount = (package.price - package.price * discount/100) * package.num_servers * subscription.months * subscription.ratio
    to_pay = amount - credits_available
    to_pay = 0 if to_pay < 0 else to_pay
    paid = to_pay == 0
    credits_used = amount - to_pay
    order = create_order(db=db, user_id=order_request_dto.user_id,
                         subscription_id=subscription.id,
                         amount_paid=to_pay,
                         package_id=order_request_dto.package_id,
                         credits_used=credits_used,
                         paid=paid,
                         promo_code=order_request_dto.promo_code,
                         licenses_count=package.num_servers)
    requests.post(url=referrals_post_successful_payment,
                  json={'user_id': order.user_id, 'ammount': order.amount_paid,
                        'credits': order.credits_used, 'promocode': order.promo_code})

    if paid:
        after_pay(db, order)
        return order, 'Order successfully created and paid'
    return order, None
