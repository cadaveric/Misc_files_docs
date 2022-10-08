#!/bin/bash
#Author
#DATE
#Purpose - Check network availability

if [ "$#" -eq "0" ]
then
SITE="mail.estiym.com 192.168.16.1 192.168.16.5 192.168.16.6 192.168.16.8"
else
SITE=$1
fi

fping -c 3 $SITE > /dev/null

if [ $? != 0 ]
then
echo `date +%F`
echo "There is a network problem"
fi


#end

