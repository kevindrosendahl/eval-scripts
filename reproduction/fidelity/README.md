# Test Reproduction:


## Generic fidelity plots

To generate throughput and delay plots for all default algorithms run:<br />
`sudo ./fidelity_base.sh`<br />

## Multiple flows and parameters

To reproduce `fidelity/data/params_plots` run:<br />
`sudo ./fidelity_params.sh`<br />

Editing the parameters in the file (`fidelity_params.sh`) as desired to test different parameter conditions.<br />

Note: the pdfs in `fidelity/data/params_plots` correspond to cwnd evolution with params:

```
<alg>-<num-flows>-<delay>-<rate>-<qsize>-cwndevo.pdf
```

## Full fidelity plots

To reproduce the `fidelity/data/*` plots and data run:<br />
`sudo ./fidelity_full.sh`<br />

## Testing our example CCP algorithms

If you want to test our TCP Vegas implementation you need to first enable it in the Linux kernel. To do this do:<br />
`sudo -i`<br />
`modprobe tcp_alg` for example `tcp_vegas`<br />

Verify it was added via:<br />
`cat /proc/sys/net/ipv4/tcp_available_congestion_control`<br /><br />
To set as default do:<br />
`echo alg > /proc/sys/net/ipv4/tcp_congestion_control`

Then uncomment the algorithm option in algorithm dictionary in `eval-scripts/scripts/start_ccp.py`. Since TCP Reno is already implemented in Rust, uncomment the lines marked `FIXME`.<br />

Now you can test our python implementions of TCP Reno and TCP Vegas which use the `portus` package to interface with CCP. A simple test run could be (from `fidelity` directory):<br />
`python3 ../../scripts/run-fidelity-exp.py --outdir test --duration 15 --alg vegas --scenario fixed --ipcs netlink --kernel --iters 1`
