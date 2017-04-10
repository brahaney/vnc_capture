#!/bin/bash
HOST=$1
PORT=$2
SLEEP=${3:-0.3}

function wait_for_service {
    # :param $1: Hostname/IP/Socket
    # :param $2: Port
    local SLEEP_VALUE=$3
    local TIMEOUT=60
    local COUNTER=0

    echo "Waiting for service at ${1}:${2}..."

    until $(nc ${1} ${2}); do
        if [[ $(echo "${COUNTER}>${TIMEOUT}" | bc) -eq 1 ]]; then
            (>&2 echo "TIMEOUT waiting for ${1}:${2}")
            exit 1
        fi
        sleep ${SLEEP_VALUE}
        COUNTER=$(echo "${COUNTER}+${SLEEP_VALUE}" | bc)
        echo "still waiting... [${COUNTER}]"
    done
    echo "service at ${1}:${2} ready after ${COUNTER} seconds."
}


echo ${VNC_PASSWORD} > .secret
wait_for_service ${HOST} ${PORT} ${SLEEP}
cd /data
flvrec.py -o vnc_recording.flv -P /.secret ${HOST} ${PORT}