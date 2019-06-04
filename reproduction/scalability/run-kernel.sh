set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DEST_DIR=${1}
SERVER=${2}
DURATION=${3}
NUM_FLOWS=${4:-1}
KERNEL_ALG=${5}

echo ${5} | sudo tee -a /proc/sys/net/ipv4/tcp_congestion_control > /dev/null

pkill cubic
killall iperf

# Run iperf longer than we collect cpu metrics so we only collect metrics during the run
${DIR}/run-iperf.sh ${DEST_DIR} ${SERVER} ${5} $((${DURATION} + 5)) ${NUM_FLOWS}

# Wait for the iperfs to begin
sleep 2

python3 ${DIR}/cpu_stats.py --outfile ${DEST_DIR}/kernel-${5}.cpu_data \
                            --freq 100 \
                            --dur ${DURATION}


