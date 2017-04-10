FROM alpine:3.5

RUN apk add --no-cache netcat-openbsd
RUN apk add --no-cache python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache
RUN apk add --no-cache python-dev build-base linux-headers bash bc
RUN pip install vnc2flv

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /data
ENV VNC_PASSWORD=secret

ENTRYPOINT ["/entrypoint.sh"]