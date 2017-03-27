FROM alpine:3.5

RUN apk add --no-cache netcat-openbsd
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache
RUN pip install vnc2flv

ENTRYPOINT "/bin/sh"