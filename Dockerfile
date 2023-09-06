FROM python:3.9-slim-buster

WORKDIR /app

COPY . /app

WORKDIR /app

# Avoid cache purge by adding requirements first
ADD ./requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=app.py

CMD ["flask", "run", "--host", "0.0.0.0"]
