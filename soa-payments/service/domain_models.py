from datetime import datetime
from sqlite3.dbapi2 import Date

from pydantic import BaseModel


class Package(BaseModel):
    id: int
    name: str
    num_servers: int
    price: float

    class Config:
        orm_mode = True


class Order(BaseModel):
    user_id: int
    amount_paid: float
    package_id: float
    paid: bool
    credits_used: float
    subscription_id: int
    licenses_count: int
    class Config:
        orm_mode = True


class BoundedLicense(BaseModel):
    id: int
    server_id: int
    user_id: int
    valid_from: Date
    valid_to: Date

    class Config:
        orm_mode = True

class AvailableLicense(BaseModel):
    id: int
    user_id: int
    months: int

    class Config:
        orm_mode = True

class PromoCode(BaseModel):
    id: int
    userID: int
    isUsed: bool
    startDate: datetime
    endDate: datetime
    discountPercentage: float
