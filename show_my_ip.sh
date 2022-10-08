#!/bin/bash
myip=`ip addr show $(ip route | awk '/default/ { print $5 }') | grep "inet" | head -n 1 | awk '/inet/ {print $2}' | cut -d'/' -f1 | cut -d'.' -f3,4|tr "." "-"`
hostnamectl set-hostname ws-ext-$myip.obs-02.local

notify-send "Your PC Number Is: $myip" && sleep 10
