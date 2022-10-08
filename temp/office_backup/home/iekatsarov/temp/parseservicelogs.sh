#!/bin/bash
#Author
#DATE
#Purpose - Parse service logs for unwelcomed connections
LOGFILE="/var/log/secure"
BADNAME="publickey"
THRESHOLD="$1"
OFFENCES=`awk '/publickey/ {print $7,$11}' $LOGFILE | wc -l`
#grep $BADNAME $LOGFILE | awk '{print $7,$11}'

if [ $# != "1" ]
then
echo "at least 1 positional paramer is required"
exit 1
fi


if [ $OFFENCES -gt $THRESHOLD ]
then
echo "somebody is offending your security"
else
echo "everything is fine"
fi




#end

