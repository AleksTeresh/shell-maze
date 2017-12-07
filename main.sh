#!/bin/bash

if [[ $# -lt 1 ]]
then
  echo 1>&2 "Please, provide a number of mazes to be generated as a first argument"
  exit 2
fi

num_of_mazes=$1

re='^[0-9]+$'
if ! [[ $num_of_mazes =~ $re ]] || ! [[ $num_of_mazes -gt 0 ]]
then
   echo 1>&2 "Please, provide an integer number greater than 0 as a first argument"
   exit 1
fi

echo "Mazes are being created..."
./create-mazes.sh "$num_of_mazes"
echo "$num_of_mazes mazes has been created"

echo "Solving the mazes..."
result="$(./solve-mazes.sh "$num_of_mazes")"
# get number of solvable mazes, number of unsolvable mazes
# and number of mazes that can be solved in one step
IFS=':' read -ra counters <<< "${result##*$'\n'}"

echo "The mazes have been solved"
echo "You can find a detailed report in ./reports/results.txt"

./print-global-stats.sh "$num_of_mazes" \
    "${counters[0]}" \
    "${counters[1]}" \
    "${counters[2]}" >> ./reports/results.txt
