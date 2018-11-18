FROM python:3.7-alpine3.7

RUN mkdir /app
WORKDIR /app

RUN apk --update add gcc musl-dev libffi-dev linux-headers python3-dev openssl-dev make bash jq curl && \
  rm -rf /tmp/* /var/cache/apk/*

COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 3003
COPY . /app

CMD python main.py
