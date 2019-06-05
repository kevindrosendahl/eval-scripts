# Fidelity testing

echo Starting base fidelity tests
cd ../../eval-scripts

# Run all algs (cubic, reno) and scenarios (fixed, drop, cell)
python3 ./scripts/run-fidelity-exp.py --outdir ./reproduction/fidelity/test_output --ipcs netlink --duration 30 --iters 10

cd reproduction/fidelity
