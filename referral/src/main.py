from typing import List

from fastapi import Depends, FastAPI, HTTPException, Header
from sqlalchemy.orm import Session
from fastapi.security.utils import get_authorization_scheme_param
from . import crud, models, schemas
from .database import SessionLocal, engine
import jwt
import configparser
import socket
import netifaces
import requests
from consul import Consul, Check
from lorem.text import TextLorem
import time
consul_port = 8500

time.sleep(10)

models.Base.metadata.create_all(bind=engine)

app = FastAPI(docs_url='/docs', openapi_url='/openapi.json')

consul = Consul(host='consul', port=8500)
agent = consul.agent
service = agent.service
check = Check.http('http://referral:5050/',
                   interval='10s', timeout='5s', deregister='10s')
ip = socket.gethostbyname('referral')
service.register('referral', service_id='referral',
                 address=ip, port=5050, check=check)

def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


def check_administrator(auth):
    scheme, credentials = get_authorization_scheme_param(auth)
    if credentials:
        public_key = "b'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs2iY+UNfz035EspzTZUeSai+FbBQC487BLsWC/BA+d5b1UFVs0k1erXnqrFBWjKzgn10r3fMfPlPn8ffK8iEuvBEoJ5vnRaHRqjhIi1DZ+h1o5sC9qhty0p5k+Nu9i0rV/CpY6PkAQw/e7kXBMWhK8zM/TAsA0GQUOaZDm/4WeNUq2roMAX+fAJZfMFiI2/WRvBQKcTY1SB6wJhC9c5QhBgWs83XR9EGP6BxyzvJMroR0kMyb+B7ITWbzpKXuUWbhsxRWm0Mz2nwHo9jsREC03wN0CnD+vocCnKjLv/4Bqy9igwKBT2bpAssR0Y7p3v1QZmSO3D4OxUhhkoWBZBCyQIDAQAB'"

        decoded = jwt.decode(
            credentials, key=public_key, verify=False
        )
        if (decoded['resource_access']['account']['roles'].__contains__('administrator')):
            return True
        else:
            raise HTTPException(status_code=400, detail="User is not an administrator")
    else:
        raise HTTPException(status_code=400, detail="Authorization failed")


def get_user(user_id, db, auth):
    db_user = crud.get_user(db=db, user_id=user_id)
    administrator = False
    if db_user is None:
        scheme, credentials = get_authorization_scheme_param(auth)
        if credentials:
            public_key = "b'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs2iY+UNfz035EspzTZUeSai+FbBQC487BLsWC/BA+d5b1UFVs0k1erXnqrFBWjKzgn10r3fMfPlPn8ffK8iEuvBEoJ5vnRaHRqjhIi1DZ+h1o5sC9qhty0p5k+Nu9i0rV/CpY6PkAQw/e7kXBMWhK8zM/TAsA0GQUOaZDm/4WeNUq2roMAX+fAJZfMFiI2/WRvBQKcTY1SB6wJhC9c5QhBgWs83XR9EGP6BxyzvJMroR0kMyb+B7ITWbzpKXuUWbhsxRWm0Mz2nwHo9jsREC03wN0CnD+vocCnKjLv/4Bqy9igwKBT2bpAssR0Y7p3v1QZmSO3D4OxUhhkoWBZBCyQIDAQAB'"

            decoded = jwt.decode(
                credentials, key=public_key, verify=False
            )
            user_id = decoded.sub
            if (decoded['resource_access']['account']['roles'].__contains__('administrator')):
                administrator = True
        else:
            raise HTTPException(status_code=400, detail="Authorization failed")
    db_user = crud.create_user(db=db, user_id=user_id, administrator=administrator)
    return db_user


@app.get("/")
def get_root():
    return "refferal"


@app.get("/plans")
def read_plans(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    plans = crud.get_plans(db, skip=skip, limit=limit)
    return plans


@app.post("/plans", response_model=schemas.Plan)
def create_plan(plan: schemas.PlanBase, db: Session = Depends(get_db)):
    db_plan = crud.get_plan_by_name(db, plan_name=plan.name)
    if db_plan:
        raise HTTPException(status_code=400, detail="Plan already exists")
    return crud.create_plan(db=db, plan=plan)


@app.get("/plans/name/{plan_name}", response_model=schemas.Plan)
def get_plan_by_name(plan_name: str, db: Session = Depends(get_db)):
    db_plan = crud.get_plan_by_name(db, plan_name=plan_name)
    if db_plan is None:
        raise HTTPException(status_code=400, detail="Plan doesn't exists")
    return db_plan


@app.get("/plans/id/{plan_id}", response_model=schemas.Plan)
def get_plan_by_name(plan_id: int, db: Session = Depends(get_db)):
    db_plan = crud.get_plan_by_id(db, plan_id=plan_id)
    if db_plan is None:
        raise HTTPException(status_code=400, detail="Plan doesn't exists")
    return db_plan


@app.post("/refferaled_user/{user_id}/{refferaled_id}")
def add_refferaled_id(user_id: str, refferaled_id: str, db: Session = Depends(get_db)):
    crud.add_refferaled_id(db=db, user_id=user_id, refferaled_id=refferaled_id)
    return {"name": "successful"}


@app.get("/vouchers", response_model=List[schemas.Voucher])
def get_vouchers(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    vouchers = crud.get_vouchers(db, skip=skip, limit=limit)
    return vouchers


@app.post("/vouchers", response_model=schemas.Voucher)
def create_voucher(voucher: schemas.VoucherBase, db: Session = Depends(get_db), Authorization: str = Header(None)):
    check_administrator(Authorization)
    return crud.create_voucher(db=db, voucher=voucher)


@app.post("/vouchers/{num_codes}", response_model=List[schemas.Voucher])
def create_vouchers(num_codes: int, voucher: schemas.VoucherBase, db: Session = Depends(get_db),
                    Authorization: str = Header(None)):
    check_administrator(Authorization)
    vouchers = []
    for i in range(num_codes):
        vouchers.append(crud.create_voucher(db=db, voucher=voucher))
    return vouchers


@app.post("/{user_id}/{voucher_code}")
def add_credits_to_user(user_id: str, voucher_code: str, db: Session = Depends(get_db)):
    db_voucher = crud.verify_voucher(db=db, voucher_code=voucher_code)
    if db_voucher is None:
        raise HTTPException(status_code=404, detail="Voucher not found")
    if db_voucher.is_used == 1:
        raise HTTPException(status_code=404, detail="Voucher is already used")
    crud.add_credits_to_user(db=db, user_id=user_id, credits=db_voucher.amount)
    crud.used_voucher(db=db, voucher_code=voucher_code, user_id=user_id)
    return {"name": "successful"}


@app.get("/referral_link/{user_id}")
def get_referral(user_id: str, db: Session = Depends(get_db), Authorization: str = Header(None)):
    db_user = get_user(user_id, db, Authorization)
    return db_user.referral_link


@app.post("/promo_codes", response_model=schemas.PromoCode)
def create_promo_code(promo_code: schemas.PromoCodeBase, db: Session = Depends(get_db),
                      Authorization: str = Header(None)):
    check_administrator(Authorization)
    return crud.create_promo_code(db=db, promo_code=promo_code)


@app.post("/promo_codes/{nums}", response_model=List[schemas.PromoCode])
def create_promo_codes(nums: int, promo_code: schemas.PromoCodeBase, db: Session = Depends(get_db),
                       Authorization: str = Header(None)):
    check_administrator(Authorization)
    promo_codes = []
    for i in range(nums):
        promo_codes.append(crud.create_promo_code(db=db, promo_code=promo_code))
    return promo_codes


@app.get("/promo_codes", response_model=List[schemas.PromoCode])
def get_promo_codes(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return crud.get_promo_codes(db=db, skip=skip, limit=limit)


@app.get("/promo_codes/id/{promo_code_id}", response_model=schemas.PromoCode)
def get_promo_code_by_id(promo_code_id: int, db: Session = Depends(get_db)):
    db_promo_code = crud.get_promo_code_by_id(db=db, promo_code_id=promo_code_id)
    if db_promo_code is None:
        raise HTTPException(status_code=400, detail="Promocode doesn't exists")
    return db_promo_code


@app.get("/promo_codes/name/{promo_code_code}", response_model=schemas.PromoCode)
def get_promo_code_by_code(promo_code_code: str, db: Session = Depends(get_db)):
    db_promo_code = crud.get_promo_code_by_code(db=db, promo_code_code=promo_code_code)
    if db_promo_code is None:
        raise HTTPException(status_code=400, detail="Promocode doesn't exists")
    return db_promo_code


@app.post("/successfulpayment")
def successful_payment(successful: schemas.SuccessfulPayment, db: Session = Depends(get_db)):
    db_user = crud.get_user(db, successful.user_id)
    if db_user.referraled_id is not None:
        db_referraled_user = crud.get_user(db, db_user.referraled_id)
        crud.add_credits_to_user(db, db_referraled_user.id, successful.amount * 0.1)
    crud.add_credits_to_user(db, db_user.id, successful.credits * (-1))
    db_promo_code = crud.get_promo_code_by_code(db, successful.promo_code)
    if db_promo_code is not None:
        crud.used_promo_code(db, db_promo_code.code, db_user.id)
    return {"successful": "payment"}

