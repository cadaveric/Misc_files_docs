#!/bin/bash
#Author
#DATE
#Purpose - Illustrate the use of select

PS3="Please select a choice: "
LIST="MESSG MAIL Quit"

select VAR in $LIST
do
if [ "$VAR" = "MESSG" ]
then 
watch tail /var/log/messages
break
elif [ "$VAR" = "MAIL" ]
then
watch tail /var/log/mail.log
break
elif [ "$VAR" = "Quit" ]
then
echo "You chose to quit."
exit
fi
done



#end

