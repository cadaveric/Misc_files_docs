#!/bin/bash
#Author: Iliyan Katsarov
#Date: 07.12.2020
#Purpose: log in to remote server and convert .xml ot .xlsx

CLEANDIR="rm -f ./*.xml"

#clean local dir from xlsx files older than 8 hours
find . -name "*.xlsx" -mmin +480 -exec rm -f {} \;

lftp -f /home/ilkatsarov/Desktop/dsn/script.sh.lftp

if [ $? -eq 0 ]
	then
	echo -e "\nWill convert files to .xlsx\n"
	ssh -o StrictHostKeyChecking=no root@192.168.16.6 "cd /etc/obs/dsn/dsn; ../convert"
	if [ $? -ne 0 ]
		then	
		echo "Error converting the files."
		exit 200
	else
		lftp -c "open -u root,xxx sftp://192.168.16.6; cd /etc/obs/dsn/dsn/; mirror"
	fi
	if [ $? -eq 0 ]
		then 
		echo -e "Will clean/remove files on the server.\n"
		ssh -o StrictHostKeyChecking=no root@192.168.16.6 "rm -f /etc/obs/dsn/dsn/*.xlsx"
	fi
fi

#clean local dir from xml files

if [ $? -eq 0 ]
then
	echo -e "Will remove .xml files from local dir.\n"
	echo "`$CLEANDIR`"
fi

#end
