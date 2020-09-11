FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

COPY requirements.txt /app/requierements.txt

RUN pip install -r /app/requierements.txt

COPY ./app /app