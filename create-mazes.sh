#!/bin/bash

# empty the mazes directory if it exists
if [[ -d "mazes" ]]
then
  rm -rf ./mazes
fi
mkdir ./mazes

for (( i=0; i<$1; i++ ))
do
  filename="maze$(($i + 1)).grh"
  ./create-maze.sh > ./mazes/$filename
done
