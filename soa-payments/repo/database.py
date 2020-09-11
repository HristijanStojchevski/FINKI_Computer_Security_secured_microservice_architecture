import os
from datetime import datetime

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from repo.repo_models import Base, AvailableLicense, BoundedLicense
from repo.repo_models import Order, Subscription

#SQLALCHEMY_DATABASE_URL = "postgresql://{user}:{password}@localhost/{dbname}".format(user=user,password=password,dbname=dbname)
SQLALCHEMY_DATABASE_URL = os.getenv('DATABASE_URI')

engine = create_engine(
    SQLALCHEMY_DATABASE_URL
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
session = SessionLocal()


def init_db():
    print("Dropping the db")
    Base.metadata.drop_all(bind=engine, tables=[Order.__table__, Subscription.__table__, AvailableLicense.__table__,
                                                BoundedLicense.__table__])
    print("Creating the db")
    Base.metadata.create_all(engine)

    #### INIT ORDERS ####
    order1 = Order(user_id=1, amount_paid=10, package_id=1, paid=False, credits_used = 0, subscription_id = 1, licenses_count = 1)
    session.add(order1)
    order2 = Order(user_id=2,  amount_paid=20, package_id=1, paid=False, credits_used = 0, subscription_id = 1, licenses_count = 1)
    session.add(order2)

    license1 = AvailableLicense(user_id=1, months=1)
    session.add(license1)
    license2 = AvailableLicense(user_id=1, months=1)
    session.add(license2)

    bounded_license1 = BoundedLicense(user_id=1, server_id=1, valid_from=datetime(year=2020, month=5, day=5),
                                      valid_to=datetime(2023, month=5, day=5))
    session.add(bounded_license1)
    bounded_license2 = BoundedLicense(user_id=1, server_id=2, valid_from=datetime(year=2018, month=5, day=5),
                                      valid_to=datetime(2019, month=5, day=5))
    session.add(bounded_license2)

    #### INIT SUBSCRIPTIONS ####
    subscription1 = Subscription(name="1 Month subscription", description="Regular monthly plan price.", ratio=1,
                                 months=1)
    session.add(subscription1)
    subscription2 = Subscription(name="3 Month subscription", description="Price with 10% monthly discount", ratio=0.9,
                                 months=3)
    session.add(subscription2)
    subscription3 = Subscription(name="6 Month subscription", description="Price with 20% monthly discount", ratio=0.8,
                                 months=6)
    session.add(subscription3)
    subscription4 = Subscription(name="1 Year subscription", description="Price with 30% monthly discount", ratio=0.7,
                                 months=12)
    session.add(subscription4)
    subscription5 = Subscription(name="3 Year subscription", description="Price with 50% monthly discount", ratio=0.5,
                                 months=36)
    session.add(subscription5)
    session.commit()


# Dependency
def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()
