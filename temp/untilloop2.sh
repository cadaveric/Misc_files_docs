#!/bin/bash
#Author
#DATE
until [ "$var" -eq "0" ]
do
ping -c 1 192.168.16.14
var=`echo $?`
done 
#end

