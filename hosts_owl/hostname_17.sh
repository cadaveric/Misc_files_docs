#!/bin/bash
who=`who | head -1 | awk 'NR==1{print $1}'`

for ((i="35";i<="45";i++))
   do 
	   sudo ping -c 1 192.168.17.$i
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -tt -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.17.$i
	    	  if [ $? -ne 0 ]
		        then
		    	  continue
		      fi
	    fi
    done >> info_17_to_change 
