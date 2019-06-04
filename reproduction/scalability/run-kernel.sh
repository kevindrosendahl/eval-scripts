set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DEST_DIR=${1}
SERVER=${2}
DURATION=${3}
NUM_FLOWS=${4:-1}
KERNEL_ALG=${5}

pkill cubic
killall iperf

# Run iperf longer than we collect cpu metrics so we only collect metrics during the run
${DIR}/run-iperf.sh ${DEST_DIR} ${SERVER} ${5} $((${DURATION} + 5)) ${NUM_FLOWS}

# Wait for the iperfs to begin
sleep 2

python3 ${DIR}/cpu_stats.py --outfile ${DEST_DIR}/kernel-${5}-${NUM_FLOWS}.cpu_data \
                            --freq 100 \
                            --dur ${DURATION}


