#!/bin/bash

#16th network
for ((i="80";i<="253";i++))
    do 
	   sudo ping -c 1 192.168.16.$i
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.16.$i "poweroff"
	    	if [ $? -ne 0 ]
		then
			continue
		fi
	    fi
    done

#17th network
for ((i="11";i<="253";i++))
    do
            sudo ping -c 1 192.168.17.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.17.$i "poweroff"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done

#18th network
for ((i="11";i<="253";i++))
    do
            sudo ping -c 1 192.168.18.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "poweroff"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done
#21st network
for ((i="1";i<="254";i++))
    do
            sudo ping -c 1 192.168.21.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.21.$i "poweroff"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done
#22nd network
for ((i="1";i<="254";i++))
    do
            sudo ping -c 1 192.168.22.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.22.$i "poweroff"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done
#23rd network
for ((i="1";i<="254";i++))
    do
            sudo ping -c 1 192.168.23.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.23.$i "poweroff"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done
