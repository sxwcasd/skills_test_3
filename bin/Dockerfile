# syntax=docker/dockerfile:1
FROM python:3.9-slim-buster
RUN /usr/local/bin/python3.9 -m pip install --upgrade pip
RUN /usr/local/bin/python3.9 -m pip install -r requirements.txt
COPY . .
