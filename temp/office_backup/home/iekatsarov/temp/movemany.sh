#!/bin/bash
#Author
#DATE
#Purpose - Illustrate the use of renaming
BADARG=165
REQPARM=2
if [ $# -ne $REQPARM ]
then
echo "Please select at least $REQPARM positional parameters"
exit=$BADARG
fi

for i in `ls -A $1*`
do
mv $i $i$2
done

#end

