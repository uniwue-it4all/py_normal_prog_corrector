FROM python:3-alpine

ARG WORKDIR=/data

WORKDIR $WORKDIR

ENTRYPOINT timeout -t 2 -s KILL python -m unittest discover -p "*_test.py"