from datetime import datetime
from typing import List

from fastapi import APIRouter
from pydantic import BaseModel

from dto.dtos import SuccessfulPaymentDTO

referrals_app = APIRouter()


class PackageDTO(BaseModel):
    id: int
    name: str
    num_servers: int
    price: float


packageDTOs = {
    1: PackageDTO(id=1, name='Tier 1', num_servers=1, price=50),
    2: PackageDTO(id=2, name='Tier 2 Linux Server', num_servers=3, price=40),
    3: PackageDTO(id=3, name='Tier 3 Linux Server', num_servers=5, price=35),
    4: PackageDTO(id=4, name='Tier 4 Linux Server', num_servers=10, price=30),
    5: PackageDTO(id=5, name='Tier 5 Linux Server', num_servers=25, price=25),
    6: PackageDTO(id=6, name='Tier 6 Linux Server', num_servers=50, price=20),
}


@referrals_app.get('/plans/id/{plan_id}', response_model=PackageDTO)
def get_plan(plan_id: int):
    return packageDTOs[plan_id]


@referrals_app.get('/plans', response_model=List[PackageDTO])
def get_plan():
    return list(packageDTOs.values())


creditsAndPromoCodes = {
    1: {'credits': 50, 'promoCodes': []},
    2: {'credits': 200, 'promoCodes': []},
    3: {'credits': 0, 'promoCodes': []}
}

promoCodes = {
    'code1': {'id': 1, 'code': 'code1', 'isUsed': True, 'discountPercentage': 10, 'startDate': datetime(2020, 3, 3),
        'endDate': datetime(2023, 3, 3), 'userID': 1},
    'code2': {'id': 2, 'code': 'code2', 'isUsed': False, 'discountPercentage': 10, 'startDate': datetime(2020, 3, 3),
        'endDate': datetime(2023, 3, 3), 'userID': 1},
    'code3': {'id': 3, 'code': 'code3', 'isUsed': True, 'discountPercentage': 10, 'startDate': datetime(2019, 3, 3),
        'endDate': datetime(2019, 4, 4), 'userID': 1},
    'code4': {'id': 4, 'code': 'code4', 'isUsed': False, 'discountPercentage': 10, 'startDate': datetime(2019, 3, 3),
        'endDate': datetime(2019, 4, 4), 'userID': 1},
    'code5': {'id': 5, 'code': 'code5', 'isUsed': True, 'discountPercentage': 10, 'startDate': datetime(2020, 3, 3),
        'endDate': datetime(2023, 3, 3), 'userID': 2},
    'code6': {'id': 6, 'code': 'code6', 'isUsed': False, 'discountPercentage': 10, 'startDate': datetime(2020, 3, 3),
        'endDate': datetime(2023, 3, 3), 'userID': 2},
}


@referrals_app.get('/{user_id}')
def get_credits_and_promo_codes(user_id: int):
    return creditsAndPromoCodes[user_id]


@referrals_app.post('/successfulPayment')
def get_credits_and_promo_codes(payment: SuccessfulPaymentDTO):
    if payment.credits:
        creditsAndPromoCodes[payment.user_id]['credits'] -= payment.credits
    if payment.promocode:
        promoCodes[payment.promocode]['isUsed'] = True
    print('User {0} spent {1} credits and paid {2}$'.format(payment.user_id, credits, payment.ammount))


@referrals_app.get('/users/{user_id}/email')
def get_user_email(user_id: int):
    return 'gjorgjinac@gmail.com'


@referrals_app.get('/promo_codes/id/{code_id}')
def get_code(code_id: str):
    return promoCodes[code_id]
