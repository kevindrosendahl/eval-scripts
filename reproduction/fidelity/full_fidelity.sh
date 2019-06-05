# Fidelity testing

echo Starting full fidelity tests
cd ../../eval-scripts

# Run algs separately to produce individual plots
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/data/cubic_fixed --ipcs netlink --duration 30 --iters 10 --alg cubic --scenario fixed
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/data/cubic_drop --ipcs netlink --duration 30 --iters 10 --alg cubic --scenario drop
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/data/cubic_cell --ipcs netlink --duration 30 --iters 10 --alg cubic --scenario cell
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/data/reno_fixed --ipcs netlink --duration 30 --iters 10 --alg reno --scenario fixed
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/data/reno_drop --ipcs netlink --duration 30 --iters 10 --alg reno --scenario drop
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/data/reno_cell --ipcs netlink --duration 30 --iters 10 --alg reno --scenario cell

cd reproduction/fidelity/data

# Plot average cwnd and cwnd histogram for each
python ../src/plot_cwnd_hist.py --indir ./cubic_fixed --outdir ./cubic_fixed
python ../src/plot_cwnd_hist.py --indir ./cubic_drop --outdir ./cubic_drop
python ../src/plot_cwnd_hist.py --indir ./cubic_cell --outdir ./cubic_cell
python ../src/plot_cwnd_hist.py --indir ./reno_fixed --outdir ./reno_fixed
python ../src/plot_cwnd_hist.py --indir ./reno_drop --outdir ./reno_drop
python ../src/plot_cwnd_hist.py --indir ./reno_cell --outdir ./reno_cell

# Plot combined throughput/delay graph
python ../src/plot_combined_tput_delay.py