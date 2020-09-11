from datetime import datetime
from sqlite3.dbapi2 import Date

from dateutil.relativedelta import relativedelta
from fastapi import HTTPException
from sqlalchemy.orm import Session

from dto.dtos import LicenseServerDTO
from repo.crud import get_bounded_license_for_server, get_available_license_by_id, add_bounded_license_for_server, \
    remove_license_with_id, get_licenses_for_user
from repo.repo_models import AvailableLicense


def get_active_server_license(db: Session, server_id):
    licenses = get_bounded_license_for_server(db, server_id)
    if licenses is None or len(licenses)==0:
        return False
    active_licenses = list(filter(lambda license: license.valid_to > Date.today(), licenses))
    return active_licenses[0] if len(active_licenses)>0 else None


def license_server(db: Session, licenseServerDto: LicenseServerDTO):
    if licenseServerDto.license_id is not None:
        license = get_available_license_by_id(db=db, license_id=licenseServerDto.license_id)
        if license == None:
            raise HTTPException(status_code=404, detail='The license has not been found')
    else:
        licenses = get_available_licenses_for_user(db=db, user_id=licenseServerDto.user_id)
        if len(licenses)==0:
            raise HTTPException(status_code=404, detail='The user has no available licenses')
        else:
            license=licenses[0]
    valid_from = datetime.now()
    valid_to = valid_from + relativedelta(months=license.months)
    created_license = add_bounded_license_for_server(db=db, server_id=licenseServerDto.server_id, user_id=licenseServerDto.user_id,
                                   valid_from=valid_from, valid_to=valid_to)
    remove_license_with_id(db=db, license_id=license.id)
    return created_license


def get_available_licenses_for_user(db: Session, user_id: int):
    return get_licenses_for_user(db=db, user_id=user_id, licenseType=AvailableLicense).all()
