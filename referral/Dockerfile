FROM python:3.7

RUN apt update && apt -y upgrade

RUN apt install -y gcc

COPY src /app/src

COPY ./requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

WORKDIR /app
EXPOSE 5050
CMD ["uvicorn", "--host", "0.0.0.0", "--port", "5050", "src.main:app"]

#docker build --network host -t server_helper_refferal .