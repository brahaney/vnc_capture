#!/bin/sh
HOST=$1
PORT=$2

function wait_for_service {
    # :param $1: Hostname/IP/Socket
    # :param $2: Port
    local SLEEP_VALUE=5
    local TIMEOUT=7200
    local COUNTER=0

    echo "Waiting for service at ${1}:${2}..."

    until $(nc ${1} ${2}); do
        if [[ ${COUNTER} -gt ${TIMEOUT} ]]; then
            (>&2 echo "TIMEOUT waiting for ${1}:${2}")
            exit 1
        fi
        sleep ${SLEEP_VALUE}
        COUNTER=$((COUNTER + SLEEP_VALUE))
        echo "still waiting..."
    done
    echo "service at ${1}:${2} ready after ${COUNTER} seconds."
}

echo ${VNC_PASSWORD} > .secret
wait_for_service ${HOST} ${PORT}
cd /data
flvrec.py -o vnc_recording.flv -P /.secret ${HOST} ${PORT}