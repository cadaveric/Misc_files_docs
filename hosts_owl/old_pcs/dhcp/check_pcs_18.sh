#!/bin/bash
for ((i=20;i<=254;i++))
do ping -c 2 -i .3 192.168.18.$i  > /dev/null 2>&1
    [ $? -eq 1 ] && continue
    ssh -i /home/ilkatsarov/keys/ws_obsbg_sp.dsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o PasswordAuthentication=no root@192.168.18.$i "who | head -1 | awk '{print $1}' && echo IP ADDRESS: 192.168.18.$i && lscpu|grep -i name && smartctl -i /dev/sda | grep -i Model && cat /etc/redhat-release && echo -e \####;"
done >> info_18.network
