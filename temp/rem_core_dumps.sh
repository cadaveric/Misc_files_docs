#!/bin/bash
#Author - ikatsarov
#DATE
#Purpose 

COREDIR="/var"
LOG="/var/log/`basename $0`.log"
if [ `find /var -name '*coredump'|wc -l` -ne 0 ]	
then
	for i in $(find /var -name '*coredump')
	do
		if [ -e $i ] && [ $? -eq 0 ]
		then
		echo "File $i exists"
		echo "Located file: $i"
		MESSG="`date +%F,\ %T`-$i has been deleted."
		rm -rf $i 
			if [ $? -eq "0" ]
			then
			echo "$MESSG"
			echo "$MESSG" >> $LOG
			fi
		fi
	done
else
	echo "No records found"
	exit 0
fi
##mail the results
MAILTO="ikatsarov@estiym.com"

mail -s "test mail sent" $MAILTO < $LOG
if [ $? -eq 0 ]
then
	echo "Mail sent to $MAILTO"
else
	echo "Err sending mail"
fi


#end
