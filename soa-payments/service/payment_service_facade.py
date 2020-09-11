from typing import List

import pybreaker
import requests
from sqlalchemy.orm import Session

from circuitbreaker.CircuitBreakerListener import CircuitBreakerListener
from dto.dtos import PackageDTO, PriceOptionDTO, PackageOfferDTO, PackageSelectedDTO
from endpoints_config import referrals_get_all_packages
from repo import crud
from repo.repo_models import Subscription
from service.domain_models import Package

packages_breaker = pybreaker.CircuitBreaker(fail_max=2, reset_timeout=10, listeners=[CircuitBreakerListener()])

@packages_breaker
def get_all_packages(db: Session):
    package_request = requests.get(referrals_get_all_packages)
    package_entities = package_request.json()
    package_entities = [Package(**package_dict) for package_dict in package_entities]
    subscription_entities = crud.get_subscriptions(db)

    shortest_sub = min(subscription_entities, key=lambda sub: sub.months)
    longest_sub = max(subscription_entities, key=lambda sub: sub.months)

    return [__convert_package_to_package_dto(package, shortest_sub, longest_sub) for package in package_entities]

@packages_breaker
def get_package_details_by_id(db: Session, package_selected: PackageSelectedDTO) -> PackageOfferDTO:
    package: PackageSelectedDTO = package_selected
    subscriptions: List[Subscription] = crud.get_subscriptions(db)
    price_options = [__create_price_option(package, sub) for sub in subscriptions]
    return PackageOfferDTO(name=package.name, description=package.description, price_options=price_options)


def __convert_package_to_package_dto(package: Package, shortest_sub: Subscription,
                                     longest_sub: Subscription) -> PackageDTO:
    min_price_per_month = (package.price * longest_sub.ratio)
    max_price_per_month = (package.price * shortest_sub.ratio)
    return PackageDTO(id=package.id, name=package.name, price=package.price,
                      min_price_per_month=min_price_per_month, max_price_per_month=max_price_per_month)


def __create_price_option(package: PackageSelectedDTO, sub: Subscription) -> PriceOptionDTO:
    price = package.price * sub.ratio
    return PriceOptionDTO(subscription_id=sub.id, description=sub.name, price=price)
