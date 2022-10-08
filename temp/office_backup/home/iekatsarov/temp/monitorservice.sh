#!/bin/bash
#Author
#DATE
#Purpose - Service Monitoring

netstat -tulpen | grep :80 > /dev/null
APACHESTATUS=`echo $?`
COUNT=0
THRESH=2
SERVICENAME="apache2"

if [ $APACHESTATUS != 0 ]
then
	while [ $COUNT -le $THRESH ]
	do
	systemctl start $SERVICENAME
		if [ "$?" -ne "0" ]
		then
		let "COUNT +=1"
		else
		exit 0
		fi
	done
	echo "Problems starting $SERVICENAME." | mail -s "$SERVICENAME failure." root 
else
	echo "$SERVICENAME is already running."
fi



#end

