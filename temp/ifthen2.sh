#!/bin/bash
#Author
#DATE
FILE1="file1"
FILE2="file3"
if [ "$FILE1" -nt "$FILE2" ]
then
echo $FILE1 is newer
else
echo $FILE2 is newer
fi


#end


