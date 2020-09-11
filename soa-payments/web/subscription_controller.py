from typing import List

from circuitbreaker.cb_call import circuitbreaker_call
from dto.dtos import PackageDTO, PackageOfferDTO, PackageSelectedDTO
from fastapi import Depends, APIRouter
from repo.database import get_db
from service import payment_service_facade
from service.payment_service_facade import packages_breaker
from sqlalchemy.orm import Session

subscription_router = APIRouter()

#todo: remove this after payment mock is integrated
@subscription_router.get(
    "/packages",
    summary="Fetch packages",
    description="Fetches all of the packages.",
    response_model=List[PackageDTO])
def get_packages(db: Session = Depends(get_db)):
    return circuitbreaker_call(packages_breaker, payment_service_facade.get_all_packages(db))


@subscription_router.post(
    "/package-offers-with-subscriptions",
    summary="Get package offers.",
    description="Get package with prices for all types of subscriptions.",
    response_model=PackageOfferDTO)
def get_package_offers_with_subscriptions(package_selected: PackageSelectedDTO, db: Session = Depends(get_db)):
    print("got throguh")
    return payment_service_facade.get_package_details_by_id(db, package_selected)
