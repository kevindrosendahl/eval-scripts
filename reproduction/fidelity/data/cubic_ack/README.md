
# Cubic ACK

This directory contains examples of CCP TCP Cubic using per-ACK reporting. The CCP algorithm appears to greatly overshoot the expected cwnd of the kernel (more so than per-RTT reporting).

We note that the default `drop` link provided in the `ccp-project/eval-scripts` repo has `mahimahi` use a  deterministic seed such that the kernel and CCP algorithms experience drops at the same time.