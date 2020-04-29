#! /bin/bash

NUM1=$(cat timer.txt | awk '{print $NF}' | sed '2d')
NUM2=$(cat timer.txt | awk '{print $NF}' | sed '1d')
echo "$NUM2 - $NUM1" | bc
