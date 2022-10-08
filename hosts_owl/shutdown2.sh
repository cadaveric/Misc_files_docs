#!/bin/bash

#16th network
for ((i="160";i="170";i++))
    do 
	   sudo ping -c 1 192.168.18.$i
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/iekatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no root@192.168.18.$i "poweroff"
	    	if [ $? -ne 0 ]
		then
			continue
		fi
	    fi
    done

#sleep 1

#17th network
#for ((i=15;i<=253;i++))
#    do ssh -i /home/iekatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no root@192.168.17.$i "poweroff"
#    [ "$?" -ne 0 ] && continue
#done

#sleep 1

#18th network
#for ((i=15;i<=253;i++))
#    do ssh -i /home/iekatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no root@192.168.18.$i "poweroff"
#[ "$?" -ne 0 ] && continue
#done
