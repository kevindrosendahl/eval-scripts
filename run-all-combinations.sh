#!/usr/bin/env bash

python3 scripts/run-fidelity-combinations.py \
 --num-flows 1 --num-flows 2 --num-flows 4 \
 --delay 10 --delay 100 --delay 500 \
 --rate 12 --rate 24 --rate 48 --rate 96 \
 --qsize 80 --qsize 160 --qsize 320 \
 ${1}
 
