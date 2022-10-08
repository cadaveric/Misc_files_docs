#!/bin/bash
#Author
#DATE

BADPARAM=165
echo -e "\n"
echo -e "$# - That's the number of positional parameters that has been fed.\n"

if [ $# -ne 2 ]
then
echo this script requires 2 parameters
exit $BADPARAM
fi

if ! [ $1 -ge 1 -a $2 -le 10 ]
then
	echo "Values are not in the required range 1-10"
	exit $BADPARAM
else	
	seq $1 $2
	echo -e "\n"
	echo -e "You've entered $# parameters\n"
fi


#end
