#!/bin/bash

mkdir -p ./mazes
rm ./mazes/*

for (( i=0; i<$1; i++ ))
do
  filename="maze$i.grh"
  ./create-maze.sh > ./mazes/$filename
done
