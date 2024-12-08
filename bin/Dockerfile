FROM python:3.9 as builder

COPY ./ /opt

WORKDIR /opt

COPY ./requirements.txt /opt/

RUN pip install --upgrade pip \
        && pip install --no-deps -r requirements.txt
