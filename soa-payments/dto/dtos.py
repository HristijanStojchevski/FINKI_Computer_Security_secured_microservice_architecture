from typing import List

import stripe
from pydantic import BaseModel


class NewlyCreatedOrderInformation(BaseModel):
    package_selected: str
    credits_deducted: float
    duration_of_order: int


class OrderCreatedResponse(BaseModel):
    information_about_new_order: NewlyCreatedOrderInformation


class UnsuccessfulResponse(BaseModel):
    error_message: str = "ERROR"


class PackageDTO(BaseModel):
    id: int
    name: str
    price: int
    min_price_per_month: float
    max_price_per_month: float


class PackageSelectedDTO(BaseModel):
    name: str
    description: str = None
    price: int


class PriceOptionDTO(BaseModel):
    subscription_id: int
    description: str = None
    price: float


class PackageOfferDTO(BaseModel):
    name: str
    description: str = None
    price_options: List[PriceOptionDTO]


class PaymentDTO(BaseModel):
    paymentIntentId: stripe.PaymentIntent = None
    orderId: int = None
    currency: str = None
    paymentMethodId: str = None
    items: List = None
    useStripeSdk: bool = None

class OrderRequestDTO(BaseModel):
    user_id: int
    package_id: int
    subscription_id: int
    promo_code: str = None

class LicenseServerDTO(BaseModel):
    user_id: int
    server_id: int
    license_id:int = None

class SuccessfulPaymentDTO(BaseModel):
    user_id: int
    credits: float = None
    ammount: float
    promocode: str = None
