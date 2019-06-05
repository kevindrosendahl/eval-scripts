set -eu

cd eval-scripts
./scripts/setup.sh ipc=0
sudo ./generic-cong-avoid/target/release/reno --ipc=netlink -i 10 &
sleep 5

iperf -s -p 4242 &

for i in `eval echo {1..${1}}`
do
	        iperf -c localhost -p 4242 -Z ccp > /dev/null &
done

sleep 5
sudo sysctl kernel.panic_on_oops=0

sleep 10
sudo reboot --reboot -f

