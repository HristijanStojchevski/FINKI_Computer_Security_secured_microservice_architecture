from typing import List

from fastapi import Depends, APIRouter
from fastapi import Request
from sqlalchemy.orm import Session
from starlette.templating import Jinja2Templates

from circuitbreaker.cb_call import circuitbreaker_call
from dto.dtos import OrderRequestDTO
from repo import crud
from repo.crud import db_breaker, get_order_by_id
from repo.database import get_db
from service import domain_models
from service.order_creation_service import create_and_save_order

order_router = APIRouter()


templates = Jinja2Templates(directory="frontend")

@order_router.get(
    "/orders", response_model=List[domain_models.Order],
    summary="Fetch all orders",
    description="Fetches all of the orders.")
def get_orders(db: Session = Depends(get_db)):
    return circuitbreaker_call(db_breaker, crud.get_orders(db, limit=100))


@order_router.post(
    "/order",
    summary="Create an order based on the package you selected",
    description="Creates an order based on the package you selected")
def create_order(order_request_dto: OrderRequestDTO, request: Request, db: Session = Depends(get_db)):
    # todo: replace with userid from token
    order, msg = create_and_save_order(db, order_request_dto)

    if msg:
        return msg
    return templates.TemplateResponse("checkout.html", {"request": request, "amount": order.amount_paid,
                                                        "orderId": order.id})


@order_router.get(
    "/mock-order/{order_id}",
)
def create_order(order_id:int,request: Request, db: Session = Depends(get_db)):
    order = get_order_by_id(db, order_id)
    return templates.TemplateResponse("checkout.html", {"request": request, "amount": order.amount_paid,
                                                        "orderId": order.id})

