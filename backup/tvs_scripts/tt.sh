#!/bin/bash
#wmctrl -r 'ipeca' -b toggle,fullscreen
#wmctrl -r 'ipeca' -b toggle,fullscreen -N "IPECA"


ipeca=`wmctrl -lx -b toggle,fullscreen | grep -i ipeca | awk '{print $1}'`
wmctrl -r 'ipeca' -b toggle,fullscreen -N "IPECA"

#import -window $ipeca /home/admins/Desktop/ipeca.png
import -window IPECA /home/admins/Desktop/ipeca.png
