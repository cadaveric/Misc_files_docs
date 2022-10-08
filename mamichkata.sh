#!/bin/bash

intf=`ip a | grep 192.168 | awk '{print $7}'`
sed -i -s 's\static\dhcp\' /etc/sysconfig/network-scripts/ifcfg-$intf

[ -f /bin/systemctl ] && systemctl restart network || service network restart

newip=`ifconfig  | grep 192.168 | awk '{print $2}'`
echo $newip | awk -F. '{print"ws-ext-" $3"-"$4".obs-02.local"}' > /etc/hostname
