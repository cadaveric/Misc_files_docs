#!/bin/bash
#Author - ikatsarov
#DATE
#Purpose 

COREDIR="/var"
LOG="/var/log/`basename $0`.log"

for i in $(find /var -name '*coredump')
do
	echo $i
	echo "$i" >> $LOG
done



#end
