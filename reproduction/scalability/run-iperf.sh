set -eu

DEST_DIR=${1}
SERVER=${2}
ALG=${3}
DURATION=${4}
NUM_FLOWS=${5:-1}

for i in `eval echo {1..${NUM_FLOWS}}`
do
        iperf -c ${SERVER} -p 4242 -Z ${ALG} -t ${DURATION} >> "${DEST_DIR}/${ALG}-iperf.log" &
done

