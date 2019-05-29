#!/bin/bash

set -eu

DEST_DIR=${1}
OUT_PREFIX=${2}
SOCK_OPT=${3}
DURATION=${4}
NUM_FLOWS=${5:-1}

for i in `eval echo {1..${NUM_FLOWS}}`
do
	iperf -c $MAHIMAHI_BASE -p 4242 -Z ${SOCK_OPT} -t ${DURATION} -i 1 > "./${DEST_DIR}/${OUT_PREFIX}-iperf-${i}.log" &
done
sleep $((${DURATION} + 2))
