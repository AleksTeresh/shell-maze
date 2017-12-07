#!/bin/bash

num_of_mazes=$1

./create-mazes.sh "$num_of_mazes"

result="$(./solve-mazes.sh "$num_of_mazes")"
IFS=':' read -ra counters <<< "${result##*$'\n'}"

./print-global-stats.sh "$num_of_mazes" \
    "${counters[0]}" \
    "${counters[1]}" \
    "${counters[2]}" >> ./reports/results.txt
