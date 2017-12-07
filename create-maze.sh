#!/bin/bash

declare -a graph
RANDOM=$$

num_of_nodes=$(($RANDOM % 50 + 2))
max_num_of_edges=$(($num_of_nodes))

for (( i=0; i<$num_of_nodes; i++ ))
do
  num_of_edges=$(($RANDOM % 10))

  for (( j=0; j<$num_of_edges; j++ ))
  do
    linked_node=$(($RANDOM % $num_of_nodes))

    if [[ $linked_node -gt $i ]]
    then
      graph[$(($max_num_of_edges * $i + $linked_node))]=true
      graph[$(($max_num_of_edges * $linked_node + $i))]=true
    fi
  done
done

for (( a=0; a<$num_of_nodes; a++ ))
do
  printf "%s " "$a"
  for (( b=0; b<$max_num_of_edges; b++ ))
  do
    if [[ ${graph[$(($max_num_of_edges * $a + $b))]} = true ]]
    then
      printf "%s " "$b"
    fi
  done

  echo ""
done
