#!/bin/bash

if ! [[ -d "reports" ]]
then
  mkdir ./reports
fi

touch ./reports/results.txt
# empty the results.txt file
truncate -s 0 ./reports/results.txt

if ! [[ -d "./java/out" ]]
then
  mkdir -p ./java/out
fi

# compile java
javac -d ./java/out ./java/*.java

# counters for the number of solvable mazes...
solvable_counter=0
# ... unsolvable mazes...
unsolvable_counter=0
#... mazes that can be solved in one step...
one_step_counter=0

for (( i=0; i<$1; i++ ))
do
  filename="maze$(($i + 1)).grh"
  output="$(java -cp ./java/out Main ./mazes/$filename)"

  ./print-maze-solution-results.sh "$i" "$output" \
    >> ./reports/results.txt

  # obtain the "solution" path of the maze
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
