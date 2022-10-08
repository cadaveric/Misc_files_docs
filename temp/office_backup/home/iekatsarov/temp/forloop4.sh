#!/bin/bash
#Author
#DATE
FILE="/etc/passwd"
COUNT=0

for user in `cat $FILE | cut -d':' -f 1,3`
do
echo $user
let "COUNT +=1"
done

echo "there are $COUNT users in the system"
#exit 0
#end

