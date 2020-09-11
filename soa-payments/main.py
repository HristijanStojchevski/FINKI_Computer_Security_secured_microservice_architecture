import os

import uvicorn
from fastapi import FastAPI
from starlette.staticfiles import StaticFiles

from mocks.referrals import referrals_app
from repo.database import init_db
from services_config import payments_app_port
from web.license_controller import license_router
from web.order_controller import order_router
from web.stripe_payment_controller import stripe_router
from web.subscription_controller import subscription_router

app = FastAPI()

static_dir = str(os.path.abspath(os.path.join(__file__, "..")))
app.mount("/frontend", StaticFiles(directory="frontend"), name="frontend")
# register_to_consul()

app.include_router(
    stripe_router,
    tags=["stripe payments"],
    responses={404: {"description": "Not found"}},
)

app.include_router(
    order_router,
    tags=["order"],
    responses={404: {"description": "Not found"}},
)

app.include_router(
    subscription_router,
    tags=["order"],
    responses={404: {"description": "Not found"}},
)


app.include_router(
    referrals_app,
    tags=["order"],
    responses={404: {"description": "Not found"}},
)

app.include_router(
    license_router,
    tags=["license"],
    responses={404: {"description": "Not found"}},
)

if __name__ == "__main__":
    init_db()
    uvicorn.run("main:app", host="0.0.0.0", port=payments_app_port, reload=True)

