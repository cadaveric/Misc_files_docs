#!/bin/bash

#16th network
for ((i="20";i<="254";i++))
   do 
	   sudo ping -c 1 192.168.18.$i
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "date | grep -i oct || timedatectl set-timezone Europe/Sofia" >> date.txt
	    	  if [ $? -ne 0 ]
		        then
		    	  continue
		      fi
	    fi
    done >> timezone_18_network.txt
