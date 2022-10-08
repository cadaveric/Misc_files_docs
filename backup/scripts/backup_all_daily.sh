#!/bin/bash
#Author: Iliyan Katsarov
#Purpose: sync important server directories

#server IPs
MAIL_NEW=mail.estiym.com
PDC=192.168.16.6
FIREWALL=10.10.3.254
STORE=192.168.16.5
VOIP=10.10.3.1
#NEW_PDC_VPS=192.168.19.4
#NEW_STORE_VPS=192.168.19.5

#rsync options
BKP_CMD_OPTS="-avz --delete --backup --backup-dir=../deleted/$(date +%A)/ --exclude=dev --exclude=proc --exclude=sys --exclude=tmp"


## daily backup of the new mail server with centos 7
rsync $BKP_CMD_OPTS root@$MAIL_NEW:/ /SRV_BACKUPS1/NEW_BACKUPS/MAIL_NEW/d/

sleep 1

## daily backup - pdc
rsync $BKP_CMD_OPTS root@$PDC:/ /SRV_BACKUPS1/NEW_BACKUPS/PDC/d/

sleep 1 

##daily backup - firewall
rsync $BKP_CMD_OPTS root@$FIREWALL:/ /SRV_BACKUPS1/NEW_BACKUPS/FIREWALL/d/

sleep 1

##daily backup - store
rsync $BKP_CMD_OPTS root@$STORE:/ /SRV_BACKUPS1/NEW_BACKUPS/STORE/d/

sleep 1 

##daily backup - voip 
rsync $BKP_CMD_OPTS root@$VOIP:/ /SRV_BACKUPS1/NEW_BACKUPS/VOIP/d/

sleep 1

###daily backup - new pdc vps
#rsync $BKP_CMD_OPTS root@$NEW_PDC_VPS:/etc /SRV_BACKUPS1/NEW_BACKUPS/NEW_PDC_VPS/d/
#rsync $BKP_CMD_OPTS root@$NEW_PDC_VPS:/var/lib /SRV_BACKUPS1/NEW_BACKUPS/NEW_PDC_VPS/d/
#rsync $BKP_CMD_OPTS root@$NEW_PDC_VPS:/var/cache/samba /SRV_BACKUPS1/NEW_BACKUPS/NEW_PDC_VPS/d/

####daily backup - new store vps
#rsync $BKP_CMD_OPTS root@$NEW_STORE_VPS:/etc /SRV_BACKUPS1/NEW_BACKUPS/NEW_STORE_VPS/d/
#rsync $BKP_CMD_OPTS root@$NEW_STORE_VPS:/home /SRV_BACKUPS1/NEW_BACKUPS/NEW_STORE_VPS/d/

