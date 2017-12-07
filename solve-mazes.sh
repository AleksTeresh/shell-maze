#!/bin/bash

mkdir -p ./reports
touch ./reports/results.txt
truncate -s 0 ./reports/results.txt

mkdir -p ./java/out
javac -d ./java/out ./java/*.java

solvable_counter=0
unsolvable_counter=0
one_step_counter=0

for (( i=0; i<$1; i++ ))
do
  filename="maze$i.grh"
  output="$(java -cp ./java/out ex5.Main ./mazes/$filename)"

  ./print-maze-solution-results.sh "$i" "$output" \
    >> ./reports/results.txt

  IFS=' ' read -ra path <<< "${output##*$'\n'}"
  if [[ $output == *"does not exist"* ]]
  then
    unsolvable_counter=$(($unsolvable_counter + 1))
  elif [[ ${#path[@]} -eq 2 ]]
  then
    one_step_counter=$(($one_step_counter + 1))
  else
    solvable_counter=$(($solvable_counter + 1))
  fi
done

echo "$solvable_counter:$unsolvable_counter:$one_step_counter"
