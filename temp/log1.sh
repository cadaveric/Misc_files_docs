#!/bin/bash
#Author
#DATE
#Purpose - Used to illustrate Syslog-like logging from our scripts

MYDATE=`date +%b\ %d\ %T`
MYHOST=`hostname`
mydirname=`dirname $0`
myscript=`basename $0`
if [ $1 -eq 0 ]
then
mymessage="Success"
else
mymessage="Failure"
fi

echo $MYDATE $MYHOST $mydirname $myscript $mymessage >> `date +%F`.$myscript.log


#end

