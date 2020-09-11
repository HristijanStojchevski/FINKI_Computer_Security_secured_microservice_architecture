FROM python:3.7

COPY . /app

WORKDIR /app

RUN pip install -U setuptools pip && \
	pip install -r requirements.txt

EXPOSE 5000

CMD python ./main.py
