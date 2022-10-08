#!/bin/bash
#Author
#DATE
netstat -tulpen | grep :80 > /dev/null
APACHE="$?"

if [ $APACHE -eq 0 ]
then
	echo Apache is up and running
	#testing MySQL
	netstat -ant | grep 3306
	MySQL="$?"
	if [ $MySQL -ne 0 ]
	then
	echo MYSql is not running
	fi
else
	echo Apache is not running
fi



#end


