killall iperf
sudo pkill cubic

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${DIR}/../setup.sh

echo "Starting cubic ccp implementation, logging to ~/crash-cubic-ccp.log"
sudo ./generic-cong-avoid/target/release/cubic --ipc=netlink --deficit_timeout=20 > ~/crash-cubic-ccp.log 2>&1 &

sleep 1

echo "Starting iperf server, logging to ~/crash-iperf-server.log"
iperf -s -p 4242 > ~/crash-iperf-server.log 2>&1 &

echo "Starting iperf client, logging to ~/crash-iperf-client.log"
iperf -c localhost -p 4242 -Z ccp -t 1 2>&1 | tee ~/crash-iperf-client.log

killall iperf
sudo pkill cubic

echo "Showing end of syslog"
tail /var/log/syslog -n 75

