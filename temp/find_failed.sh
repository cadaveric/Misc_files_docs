#!/bin/bash
#Author - ikatsarov
#DATE
#Purpose - find filed logins by parsing an auth file, i.e /var/log/secure

#Define source file
LOG=/var/log/secure

#Define user

if [ ! -z $1 ] 
then
	MYUSER="$1"
	MATCH="0"
	for i in `awk -F: '{ print $1 }' /etc/passwd`
       	do 
		if [ $i = "$MYUSER" ]
		then
		MATCH="1"
		fi	
	done


	if [ $MATCH -eq 0 ]
	then
		echo "User \"$MYUSER\" does not exist in /etc/passwd"
		exit 200
	fi
fi

#Define search string
MESSG="user=$MYUSER"

echo -e "\nLooking for keyword \"$MESSG\"\n"

echo -e "\nthe number of found lines is `grep $MESSG $LOG | wc -l`\n"

#grep "$MESSG" $LOG || echo -e "No records found for user $USER\n" && exit 1

#records=`grep "$MESSG" $LOG` || exit 1 --> this is logical "or" - if the previos command fails, exit with "exit status" 1

records=`grep "$MESSG" $LOG`

if [ -n "$records" ]; then
	echo "$records"
else
	echo "No records found for user: $MYUSER"
	exit 1
fi



#end
