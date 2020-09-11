import random
import string
from datetime import datetime

from sqlalchemy.orm import Session

from . import models, schemas


def get_plans(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Plan).offset(skip).limit(limit).all()

def create_plan(db: Session, plan: schemas.PlanBase):
    db_plan = models.Plan(name=plan.name, num_servers=plan.num_servers, price=plan.price)
    db.add(db_plan)
    db.commit()
    db.refresh(db_plan)
    return db_plan

def create_voucher(db: Session, voucher: schemas.VoucherBase):
    voucher_postoi = "test"
    while voucher_postoi != None:
        random_code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))
        voucher_postoi = db.query(models.Voucher).filter(models.Voucher.code == random_code).first()

    print(random_code)
    db_voucher = models.Voucher(code=random_code,
                                amount=voucher.amount,
                                start_date=voucher.start_date)
    db.add(db_voucher)
    db.commit()
    db.refresh(db_voucher)
    return db_voucher

def get_plan_by_name(db: Session, plan_name: str):
    return db.query(models.Plan).filter(models.Plan.name == plan_name).first()

def get_plan_by_id(db: Session, plan_id: int):
    return db.query(models.Plan).filter(models.Plan.id == plan_id).first()

def get_promo_codes(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.PromoCode).filter(models.PromoCode.is_used == 0).offset(skip).limit(limit).all()

def get_promo_code_by_id(db: Session, promo_code_id: int):
    return db.query(models.PromoCode).filter(models.PromoCode.id == promo_code_id).first()

def get_promo_code_by_code(db: Session, promo_code_code: str):
    return db.query(models.PromoCode).filter(models.PromoCode.code == promo_code_code).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.User).offset(skip).limit(limit).all()

def get_user(db: Session, user_id: str):
    return db.query(models.User).filter(models.User.id == user_id).first()

def get_vouchers(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Voucher).filter(models.Voucher.is_used == False).offset(skip).limit(limit).all()

def verify_voucher(db: Session, voucher_code: str):
    return db.query(models.Voucher).filter(models.Voucher.code == voucher_code).first()

def add_credits_to_user(db: Session, user_id: str, credits: float):
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    db_user.credits += credits
    db.commit()

def used_voucher(db: Session, voucher_code: str, user_id: str):
    db_voucher = db.query(models.Voucher).filter(models.Voucher.code == voucher_code).first()
    db_voucher.is_used = 1
    db_voucher.end_date = datetime.now()
    db_voucher.user_id = user_id
    db.commit()

def used_promo_code(db: Session, promo_code_code: str, user_id: str):
    db_promo_code = db.query(models.PromoCode).filter(models.PromoCode.code == promo_code_code).first()
    db_promo_code.is_used = 1
    db_promo_code.end_date = datetime.now()
    db_promo_code.user_id = user_id
    db.commit()

def create_user(db: Session, user_id: str, administrator: bool):
    referral_link = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))
    db_user = models.User(id=user_id, administrator=administrator, referral_link=referral_link)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def create_promo_code(db: Session, promo_code: schemas.PromoCodeBase):
    promo_code_postoi = "test"
    while promo_code_postoi != None:
        random_code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))
        promo_code_postoi = db.query(models.PromoCode).filter(models.PromoCode.code == random_code).first()

    # print(random_code)
    db_promo_code = models.PromoCode(code=random_code,
                                discount_percentage=promo_code.discount_percentage,
                                start_date=promo_code.start_date)
    db.add(db_promo_code)
    db.commit()
    db.refresh(db_promo_code)
    return db_promo_code

def add_refferaled_id(db: Session, user_id: str, refferaled_id: str):
    db_user = db.query(models.User).filter(models.User.id == user_id).first()
    db_user.referraled_id = refferaled_id
    db.commit()



# def get_user(db: Session, user_id: int):
#     return db.query(models.User).filter(models.User.id == user_id).first()
#
#
# def get_user_by_email(db: Session, email: str):
#     return db.query(models.User).filter(models.User.email == email).first()
#
#
# def get_users(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.User).offset(skip).limit(limit).all()
#
#
#
# def create_user(db: Session, user: schemas.UserCreate):
#     fake_hashed_password = user.password + "notreallyhashed"
#     db_user = models.User(email=user.email, hashed_password=fake_hashed_password)
#     db.add(db_user)
#     db.commit()
#     db.refresh(db_user)
#     return db_user
#
#
# def get_items(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.Item).offset(skip).limit(limit).all()
#
#
# def create_user_item(db: Session, item: schemas.ItemCreate, user_id: int):
#     db_item = models.Item(**item.dict(), owner_id=user_id)
#     db.add(db_item)
#     db.commit()
#     db.refresh(db_item)
#     return db_item