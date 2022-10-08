#!/bin/bash

#16th network
for ((i="20";i<="254";i++))
   do 
	   sudo ping -c 1 192.168.16.$i
	    if [ $? -ne 0 ]
	    then
		    continue
	    else
	    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.16.$i "cat /etc/hostname && ip a | grep 192.168"
	    	if [ $? -ne 0 ]
		then
			continue
		fi
	    fi
    done >> results_host_all_company.txt

sleep 1

#17th network
for ((i="10";i<="254";i++))
    do
           sudo ping -c 1 192.168.17.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.17.$i "cat /etc/hostname && ip a | grep 192.168"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done >> results_host_all_company2.txt

#18th network
for ((i="10";i<="254";i++))
    do
           sudo ping -c 1 192.168.18.$i
            if [ $? -ne 0 ]
            then
                    continue
            else
            ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "cat /etc/hostname && ip a | grep 192.168"
                if [ $? -ne 0 ]
                then
                        continue
                fi
            fi
    done >> results_host_all_company3.txt

