#!/bin/bash
#Author
#DATE
NUM=10000
MIN=19

until [ "$NUM" -eq "$MIN" ]
do
echo $NUM
let "NUM -=1"

done



#end

