#!/bin/bash
#Author - ikatsarov
#DATE
#Purpose - Connect via SSH to remote hosts and check service availability

echo "Service Check Script Starting"
SSHUSER="root"
HOST1="mail.estiym.com"
ID1="/home/iliyan/new-servers"
ID2="/home/iliyan/new-routers"

echo "Connecting to host: $HOST1"
IMAP=`ssh -i $ID1 $SSHUSER@$HOST1 "ps -aux | grep -v grep | grep -i imapd | grep -i pid"`

#echo "$SSHDUMP"

if [ ! -z "$IMAP" ]
then
IMAP2="imap"
echo "$IMAP2 is running at $HOST1"
else
echo "Service is not running"
fi


#end
