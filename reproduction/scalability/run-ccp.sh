set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DEST_DIR=${1}
SERVER=${2}
DURATION=${3}
NUM_FLOWS=${4:-1}
CCP_ALG=${5}

${DIR}/../setup.sh
echo 'ccp' | sudo tee -a /proc/sys/net/ipv4/tcp_congestion_control > /dev/null

sudo pkill cubic
sudo pkill reno
killall iperf

cd ${DIR}/../..
sudo ./generic-cong-avoid/target/release/${CCP_ALG} --ipc=netlink &

# Allow cpu reporting to catch up from work above
sleep 5


# Run iperf longer than we collect cpu metrics so we only collect metrics during the run
${DIR}/run-iperf.sh ${DEST_DIR} ${SERVER} 'ccp' $((${DURATION} + 5)) ${NUM_FLOWS}

# Wait for the iperfs to begin
sleep 2

python3 ${DIR}/cpu_stats.py --outfile ${DEST_DIR}/ccp-${CCP_ALG}-${NUM_FLOWS}.cpu_data \
                            --freq 100 \
                            --dur ${DURATION}

