#!/bin/bash

./scripts/reset.sh

# don't need to be un-done
sudo modprobe tcp_bbr
sudo modprobe tcp_probe port=4242
sudo sysctl -w net.ipv4.ip_forward=1

echo "---Build portus---"
cd portus && make > ../$2/build_tmp 2> ../$2/build_tmp
if [ $? -ne 0 ]
then
    cat ../$2/build_tmp
else
    #rm $2/build_tmp
    cd ..
fi
echo "---Build ccp_copa---"
cd ccp_copa && cargo build > ../$2/build_tmp 2> ../$2/build_tmp
if [ $? -ne 0 ]
then
    cat ../$2/build_tmp
else
    #rm $2/build_tmp
    cd ..
fi
echo "---Build ccp-kernel---"
cd ccp-kernel && make > ../$2/build_tmp 2> ../$2/build_tmp
if [ $? -ne 0 ]
then
    cat ../$2/build_tmp
else
    #rm $2/build_tmp
    cd ..
fi

ulimit -Sn 8192
cd ccp-kernel && sudo ./ccp_kernel_load $1 && cd ..
