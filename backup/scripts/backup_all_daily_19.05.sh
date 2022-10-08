#!/bin/bash

MAIL_NEW=mail.estiym.com
PDC=192.168.16.6
FIREWALL=192.168.16.1
STORE=192.168.16.5
VOIP=192.168.16.2

BKP_CMD_OPTS="-avz --delete --backup --backup-dir=../deleted/$(date +%A) --exclude=dev --exclude=proc --exclude=sys --exclude=tmp"


if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/MAIL_NEW/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/MAIL_NEW/deleted/$(date +%A);
fi

sleep 1

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/PDC/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/PDC/deleted/$(date +%A);
fi
sleep 1

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/FIREWALL/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/FIREWALL/deleted/$(date +%A);
fi

sleep 1

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/STORE/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/STORE/deleted/$(date +%A);
fi

sleep 1

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/VOIP/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/VOIP/deleted/$(date +%A);
fi

## daily backup of the new mail server with centos 7
rsync $BKP_CMD_OPTS root@$MAIL_NEW:/ /SRV_BACKUPS1/NEW_BACKUPS/MAIL_NEW/d

sleep 1

## daily backup - pdc
rsync $BKP_CMD_OPTS root@$PDC:/ /SRV_BACKUPS1/NEW_BACKUPS/PDC/d

sleep 1 

##daily backup - firewall
rsync $BKP_CMD_OPTS root@$FIREWALL:/ /SRV_BACKUPS1/NEW_BACKUPS/FIREWALL/d

sleep 1

##daily backup - store
rsync $BKP_CMD_OPTS root@$STORE:/ /SRV_BACKUPS1/NEW_BACKUPS/STORE/d

sleep 1 

##daily backup - voip 
rsync $BKP_CMD_OPTS root@$VOIP:/ /SRV_BACKUPS1/NEW_BACKUPS/VOIP/d
