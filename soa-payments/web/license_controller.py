from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from dto.dtos import LicenseServerDTO
from repo.database import get_db
from service.domain_models import BoundedLicense, AvailableLicense
from service.license_service import license_server, get_available_licenses_for_user, \
    get_active_server_license

license_router = APIRouter()


@license_router.get('/licenses/server/{server_id}', response_model= BoundedLicense)
def get_server_license(server_id: int, db: Session = Depends(get_db)):
    return get_active_server_license(db=db, server_id=server_id)

@license_router.post('/licenses/server', response_model=BoundedLicense)
def user_license(licenseServerDto: LicenseServerDTO, db: Session = Depends(get_db)):
    return license_server(db=db, licenseServerDto = licenseServerDto)

@license_router.get('/licenses/user/{user_id}', response_model=List[AvailableLicense])
def get_licenses(user_id: int, db: Session = Depends(get_db)):
    return get_available_licenses_for_user(db=db, user_id=user_id)
