#!/bin/bash

#export ssh_server=estiym.com # the domain name or ip if you want 
#export ssh_user=root # the ssh user to use to
#export src_dir=/home/admins/Desktop/ # the source dir
    # the full path to the ssh identity file 
#export ssh_idty=/home/admins/new-server_01.10.2010_pdc
#export tgt_dir=/var/www/html/4/ # the target dir
   # Action !!!
##    rsync -e "ssh -l root -i $ssh_idty" -av -r --partial --progress --human-readable \
##       --stats $ssh_user@$ssh_server:$src_dir $tgt_dir
##    # and check the result
##    clear ; find $tgt_dir -type d -maxdepth 1|sort -nr| less


# raiseAll - Mark Belanger - raise all windows
#$curPATH=pwd
#ls -lart $curPATH
#rm $curPATH/screenshot* -rf
rm /home/admins/Desktop/screenshot* -rf
#sleep 1
# get the ID of the current desktop
thisDT=`wmctrl -d |grep ' \* ' | awk '{print $1}'`

#echo Raising windows for desktop $thisDT
for window in `wmctrl -l |grep " $thisDT " | awk '{print $1}'`
do
  #echo Raising $window - put your screenshot command here
 # 12.03.2021 import -window $window  -delay 200 /home/alex/Desktop/screenshot-$window.png

#wmctrl -r $thisDT -b toggle,fullscreen



########################################
#################### chrome - goto full screen wmctrl -r chrome -b toggle,fullscreen
#######################################


#sleep 1
####import -window $window -delay 1  /home/admins/Desktop/screenshot-$window.png





#import -window $window /home/admins/Desktop/screenshot-$window.png





#import -window /home/admins/Desktop/$window.png
 #wmctrl -i -a $window
 sleep 1
done

#ipeca=`wmctrl -lx -b toggle,fullscreen | grep -i ipeca | awk '{print $1}'`
rm /home/admins/Desktop/img/*.png -f

#sleep 1

######### ipeca image
ipeca=`wmctrl -lx  | grep -i ipeca | awk '{print $1}'`
import -window $ipeca /home/admins/Desktop/img/ipeca.png

#sleep 1

############ swica image
swica=`wmctrl -lx  | grep SWICA | awk '{print $1}'`
sleep 1
import -window $swica /home/admins/Desktop/img/swica.png

########## mercer 
mercer=`wmctrl -lx | grep -i MERCER | awk '{print $1}'`
sleep 1
import -window $mercer /home/admins/Desktop/img/mercer.png

###### call centers - 1st and 2nd floor
callcenter=`wmctrl -lx | grep -i "call centres" | awk '{print $1}'`
sleep 1
import -window $callcenter /home/admins/Desktop/img/call.png

########## s2h


s2h=`wmctrl -lx | grep -i s2h | awk '{print $1}'`
sleep 1
import -window $s2h /home/admins/Desktop/img/s2h.png

#### AON 


aon=`wmctrl -lx | grep -i aon | awk '{print $1}'`
sleep 1
import -window $aon /home/admins/Desktop/img/aon.png

####### viamedis

viamedis=`wmctrl -lx | grep -i viamedis | awk '{print $1}'`
sleep 1
import -window $viamedis /home/admins/Desktop/img/viamedis.png


##### SN
SN=`wmctrl -lx | grep -i SN | awk '{print $1}'`
sleep 1
import -window $SN /home/admins/Desktop/img/SN.png


######## santiane
santiane=`wmctrl -lx | grep -i santiane | awk '{print $1}'`
sleep 1
import -window $santiane /home/admins/Desktop/img/santiane.png

#### LMDE

LMDE=`wmctrl -lx | grep -i LMDE | awk '{print $1}'`
sleep 1
import -window $LMDE /home/admins/Desktop/img/LMDE.png



#rsync -e "ssh -l root -i $ssh_idty" -av -r --partial --progress --human-readable \
#        --stats $ssh_user@$ssh_server:$src_dir $tgt_dir
# and check the result
#    clear ; find $tgt_dir -type d -maxdepth 1|sort -nr| less


#scp -i /home/admins/new-server_01.10.2010_pdc /home/admins/Desktop/screenshot-* root@estiym.com:/var/www/html/4/
#scp -i /home/admins/new-server_01.10.2010_pdc /home/admins/Desktop/screenshot-* root@estiym.com:/var/www/html/5/

#rsync -avz --force /home/admins/Desktop/screenshot-* root@estiym.com:/var/www/html/4/
#ssh -i /home/admins/new-server_01.10.2010_pdc root@estiym.com

#rsync -e "ssh -i /home/admins/new-server_01.10.2010_pdc" -av -r  /home/admins/Desktop/*.png root@estiym.com:/var/www/html/4/
rsync -e "ssh -i /home/admins/newest_mail_16.6" -av -r  /home/admins/Desktop/img/*.png root@estiym.com:/var/www/html/files/
rsync -e "ssh -i /home/admins/newest_mail_16.6" -av -r  /home/admins/Desktop/img/*.png root@estiym.com:/var/www/html/41/
rsync -e "ssh -i /home/admins/newest_mail_16.6" -av -r  /home/admins/Desktop/img/*.png root@estiym.com:/var/www/html/5/


/home/admins/Desktop/loop.sh
