#!/bin/bash
#Author
#DATE
#Purpose - Used to backup files/directories locally and store remotely

BACKUPDIR="/home/iekatsarov/backup"
SCRIPTDIR="/home/iekatsarov/temp /home/iekatsarov/.ssh /home/iekatsarov/add_ssh_keys.sh /home/iekatsarov/.getssl /home/iekatsarov/keys /home/iekatsarov/OBS-UPDATES-GPG-KEY"
BACKUPHOST="root@10.254.252.234:/root/temp/office_backup/"
BACKUPFILE="scripts.backup.`date +%F.tgz`"
THRESHOLD=7

function backupdir() {

if [ ! -e $BACKUPDIR ]
then
	echo "Creating backup directory because it doesn't exist"
	mkdir $BACKUPDIR
	if [ $? != 0 ] ; then echo "Failed to create dir"; exit 1; fi
	COUNT=0
else
	COUNT=`ls $BACKUPDIR/scripts.* | wc -l`
fi
}

function backup() {
if [ $COUNT -le $THRESHOLD ]
then
	tar -cvzf $BACKUPDIR/$BACKUPFILE $SCRIPTDIR > /dev/null
	if [ $? != 0 ] ; then echo "Error creating backup file" ; fi
	scp $BACKUPDIR/$BACKUPFILE $BACKUPHOST
	if [ $? != 0 ] ; then echo "Error sending backup file to backup host" ; fi
fi
}

backupdir
backup

#end

