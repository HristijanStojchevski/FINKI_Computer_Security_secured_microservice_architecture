from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Float, DateTime
from sqlalchemy.orm import relationship

from .database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(String(50), primary_key=True, index=True)
    referral_link = Column(String(50), unique=True, index=True)
    credits = Column(Float, default=0.0)
    administrator = Column(Boolean, default=False)
    referraled_id = Column(String(50), nullable=True)


class Plan(Base):
    __tablename__ = "plans"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False)
    num_servers = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)


class Voucher(Base):
    __tablename__ = "voucher"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(50), unique=True)
    is_used = Column(Boolean, default=False)
    amount = Column(Float, nullable=False)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=True)
    user_id = Column(String(50), ForeignKey('users.id'), nullable=True)


class PromoCode(Base):
    __tablename__ = "promo_code"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(50), unique=True)
    is_used = Column(Boolean, default=False)
    discount_percentage = Column(Float)
    start_date = Column(DateTime)
    end_date = Column(DateTime)
    user_id = Column(String(50), ForeignKey('users.id'), nullable=True)