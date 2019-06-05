# Multiple parameters fidelity testing

echo Starting multiple parameters fidelity tests
cd ../../eval-scripts

python3 ./scripts/run-fidelity-combinations.py --alg cubic --num-flows 1 --delay 10 --rate 96 --qsize 160
