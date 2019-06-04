set -eu

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DEST_DIR=${1}
SERVER=${2}
DURATION=${3}
NUM_FLOWS=${4:-1}
CCP_ALG=${5}

${DIR}/../setup.sh
echo 'ccp' | sudo tee -a /proc/sys/net/ipv4/tcp_congestion_control > /dev/null

pkill cubic
pkill reno 
killall iperf

${DIR}/../../generic-cong-avoid/target/release/${CCP_ALG}


# Run iperf longer than we collect cpu metrics so we only collect metrics during the run
${DIR}/run-iperf.sh ${DEST_DIR} ${SERVER} 'ccp' $((${DURATION} + 5)) ${NUM_FLOWS}

# Wait for the iperfs to begin
sleep 2

python3 ${DIR}/cpu_stats.py --outfile ${DEST_DIR}/ccp-${CCP_ALG}.cpu_data \
                            --freq 100 \
                            --dur ${DURATION}

