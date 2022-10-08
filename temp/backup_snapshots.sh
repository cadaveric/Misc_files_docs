#!/bin/bash
#Author - ikatsarov
#DATE
#Purpose 
SRC="/home/iekatsarov/temp/"
DST="/home/iekatsarov/scripts_backup"
BFILETAR=`date +%F`.backup.tar
BFILEBZ2=`date +%F`.backup.tar.bz2
BCMD="tar -cjvf $DST/$BFILEBZ2 $SRC"

if [ ! -e $DST ]
then 
	echo "Dir $DST doesn't exist, will create it"
	mkdir $DST
fi

if [ ! -f "$DST/$BFILEBZ2" ]
then
	echo "The current backup file does not exist"
	echo "Will create: $BFILEBZ2"
        echo "`$BCMD`"
else
	echo -e "\nThe current file $DST/$BFILEBZ2 exists, will unzip and update it.\n"
	bunzip2 $DST/$BFILEBZ2
	tar -uvf $DST/$BFILETAR $SRC
	echo "`$BCMD`"
fi

if [ $? -eq 0 ]
then
	echo -e "\nWill remove the tar $BFILETAR file\n"
	rm -f $DST/$BFILETAR
fi
#end
