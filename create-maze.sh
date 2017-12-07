#!/bin/bash

# an array that represents the maze
# the array represents 2D matrix of size $num_of_nodes by $num_of_nodes
# the matrix is implemented as a 1D array i.e. the rows
# are concatenated
declare -a graph
RANDOM=$$

# randomly get a number of nodes on the maze
# make sure it is not smaller than 2
num_of_nodes=$(($RANDOM % 50 + 2))
# max number of edges is 10
max_num_of_edges=10

# for each node, generate random number of edges to other nodes
for (( i=0; i<$num_of_nodes; i++ ))
do
  # make sure the number of edges is not greater than the defined max
  num_of_edges=$(($RANDOM % $(($max_num_of_edges + 1))))

  for (( j=0; j<$num_of_edges; j++ ))
  do
    #randomely select to which node the edge leads
    linked_node=$(($RANDOM % $num_of_nodes))

    # if the node has number greater than the current node
    if [[ $linked_node -gt $i ]]
    then
      # add edges between the nodes
      # we assume that it is possible to pass in either directions
      graph[$(($num_of_nodes * $i + $linked_node))]=true
      graph[$(($num_of_nodes * $linked_node + $i))]=true
    fi
  done
done

# iterate through all the nodes and print node numbers to which
# they are connected
for (( a=0; a<$num_of_nodes; a++ ))
do
  printf "%s " "$a"
  for (( b=0; b<$num_of_nodes; b++ ))
  do
    if [[ ${graph[$(($num_of_nodes * $a + $b))]} = true ]]
    then
      printf "%s " "$b"
    fi
  done

  echo ""
done
