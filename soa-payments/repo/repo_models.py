from sqlalchemy import Column, Integer, String, Float, Date, Boolean
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class Order(Base):
    __tablename__ = "orders"

    id = Column(Integer, primary_key=True, index=True)
    amount_paid = Column(Float)
    package_id = Column(Integer)
    user_id=Column(Integer)
    paid = Column(Boolean)
    credits_used = Column(Float)
    subscription_id = Column(Integer)
    licenses_count = Column(Integer)
    promo_code = Column(String)

class Subscription(Base):
    __tablename__ = "subscriptions"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True)
    description = Column(String)
    ratio = Column(Float)
    months = Column(Integer)

class BoundedLicense(Base):
    __tablename__ = 'bounded_licenses'
    id = Column(Integer, primary_key=True, index=True)
    server_id = Column(Integer)
    user_id=Column(Integer)
    valid_from = Column(Date)
    valid_to = Column(Date)

class AvailableLicense(Base):
    __tablename__ = 'available_licenses'
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    months = Column(Integer)