#!/bin/bash
myscript=`basename $0`
echo $myscript

for i in `ls -A`
do
if [ $i != $myscript ]
then newname=`echo $i | tr A-Z a-z`
mv $i $newname
elif
[ $i = $myscript ]
then 
echo "Can't rename myself"
else	
echo "shit"
fi



done
