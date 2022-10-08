#!/bin/bash

#stop firewall
for ((i="10";i<="254";i++))
    do 
	   sudo ping -c 1 192.168.18.$i > /dev/null
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "/etc/obs/prepare_for_profile_sync.sh"
	    	if [ $? -ne 0 ]
		then
			continue
		fi
	    fi
    done

    sleep 1
### check if Sophos setup is available, if not - copy it
for ((i="10";i<="254";i++))
    do
           sudo ping -c 1 192.168.18.$i > /dev/null
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "[ ! -e /home/SophosSetup_new.sh ]" && scp /home/ilkatsarov/Downloads/SophosSetup_new.sh root@192.168.18.$i:/home/
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done

    sleep 1
#### Install the script
for ((i="10";i<="254";i++))
    do
           sudo ping -c 1 192.168.18.$i > /dev/null
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "bash /home/SophosSetup_new.sh"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done
