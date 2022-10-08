#!/bin/bash
#Author - ikatsarov
#DATE
#Purpose 

# Parse "/" mount point
FREE=$(df / | grep '% /' | awk '{ print $4 }')

# Ensure that a min number of blocks is available
MIN="100000000"
if [ $FREE -gt "$MIN" ]
then
	echo "Sufficient storage exists - $FREE blocks"
	LOG=/root/temp/df.log
	touch $LOG
	if [ $? -eq 0 ]
	then 
		echo "LOG file: \"$LOG\" successfully created."
	else
		echo "Error creating $LOG file"
		exit 1
	fi
else
	echo "Insufficient storage exists - only $FREE remain, it requires at least $MIN blocks"
	exit 1
fi

#end
