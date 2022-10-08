#!/bin/bash

#16th network
for ((i="1";i<="254";i++))
   do 
	   sudo ping -c 1 192.168.23.$i
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.23.$i "sed 's/0219/0220/' /etc/obs/updates/VERSION; /etc/obs/updates/do_update" 
	    	  if [ $? -ne 0 ]
		        then
		    	  continue
		      fi
	    fi
    done 
