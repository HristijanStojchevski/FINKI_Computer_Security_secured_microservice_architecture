from typing import List

import pybreaker
from sqlalchemy import Date
from sqlalchemy.orm import Session

from circuitbreaker.CircuitBreakerListener import CircuitBreakerListener
from repo import repo_models
from repo.repo_models import Base, BoundedLicense, AvailableLicense, Subscription, Order

db_breaker = pybreaker.CircuitBreaker(fail_max=2, reset_timeout=10, listeners=[CircuitBreakerListener()])


@db_breaker
def get_orders(db: Session, skip: int = 0, limit: int = None) -> List[repo_models.Order]:
    return __get_all(db, repo_models.Order, skip, limit)


@db_breaker
def get_subscriptions(db: Session, skip: int = 0, limit: int = None) -> List[repo_models.Subscription]:
    return __get_all(db, repo_models.Subscription, skip, limit)


@db_breaker
def __get_all(db, what: Base, skip: int, limit: int):
    return db.query(what).offset(skip).limit(limit).all()


@db_breaker
def get_bounded_license_for_server(db, server_id: int):
    return db.query(BoundedLicense).filter(BoundedLicense.server_id == server_id).all()


@db_breaker
def add_bounded_license_for_server(db: Session, server_id: int, valid_from: Date, valid_to: Date, user_id: int):
    license = BoundedLicense(server_id=server_id, valid_from=valid_from, valid_to=valid_to, user_id=user_id)
    db.add(license)
    db.commit()
    db.refresh(license)
    return license


@db_breaker
def add_available_license_for_user(db: Session, user_id: int, months: int):
    license = AvailableLicense(user_id=user_id, months=months)
    db.add(license)
    db.commit()
    db.refresh(license)
    return license


@db_breaker
def remove_license_with_id(db: Session, license_id: int):
    license = db.query(AvailableLicense).filter(AvailableLicense.id == license_id).first()
    db.delete(license)
    db.commit()


@db_breaker
def get_licenses_for_user(db: Session, user_id: int, licenseType: Base):
    return db.query(licenseType).filter(licenseType.user_id == user_id)


@db_breaker
def get_available_license_by_id(db: Session, license_id: int):
    return db.query(AvailableLicense).filter(AvailableLicense.id == license_id).first()


@db_breaker
def get_subscription_by_id(db: Session, sub_id: int):
    return db.query(Subscription).filter(Subscription.id == sub_id).first()


@db_breaker
def create_order(db: Session, user_id: int,
                 amount_paid: float,
                 package_id: int,
                 credits_used: bool,
                 licenses_count: int,
                 subscription_id: int,
                 promo_code: str,
                 paid: bool):
    order = Order(user_id=user_id, amount_paid=amount_paid, package_id=package_id, paid=paid, credits_used=credits_used,
                  licenses_count=licenses_count, subscription_id = subscription_id, promo_code = promo_code)
    db.add(order)
    db.commit()
    db.refresh(order)
    return order


@db_breaker
def get_order_by_id(db: Session, order_id: int) -> Order:
    return db.query(Order).filter(Order.id == order_id).first()
