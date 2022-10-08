#!/bin/bash
#Date: 04.10.2020
#Author: ikatsarov
#Purpose: testing stuff

#Begin variables

MESSAGE="hello world"
MESSAGE2="the world is mine"
#Begin code
clear
date +%F,\ %r
echo -e "$MESSAGE"'\n'"$MESSAGE2"
echo "What is your name?"
read NAME
clear
echo "Hello, $NAME"
#echo "Script name:`basename $0`"
echo "you are currently in $PWD, but were in $OLDPWD"; echo "the time is `date +%r`"

#Sourcing another file - in this case third.sh
echo "Demonstration of sourcing a file in BASH"
#. fourth.sh
. third.sh

#Inclusion of a logging script - if the exit status of the previous command is 0, source the script with 0, else source with 1(failure).
if [ $? -eq 0 ]
then
source log1.sh 0
else
source log1.sh 1
fi



















#end
