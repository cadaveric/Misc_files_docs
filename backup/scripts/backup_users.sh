#!/bin/bash

MSILOVA=192.168.22.83
SPISHEVA=192.168.21.201
TPENERLIEVA=192.168.17.99
VTOTOV=192.168.22.79
TDJAMBOVA=192.168.17.65

BKP_CMD_OPTS="-avz --delete --backup --backup-dir=../deleted/$(date +%A) --exclude=dev --exclude=proc --exclude=sys --exclude=tmp"

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/MSILOVA/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/MSILOVA/deleted/$(date +%A);
fi

sleep 1

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/SPISHEVA/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/SPISHEVA/deleted/$(date +%A);
fi

sleep 1

if [ ! -d /SRV_BACKUPS1/NEW_BACKUPS/TPENERLIEVA/deleted/$(date +%A) ]; then
  mkdir -p /SRV_BACKUPS1/NEW_BACKUPS/TPENERLIEVA/deleted/$(date +%A);
fi

##daily backup tmitkova - SN
rsync $BKP_CMD_OPTS root@$MSILOVA:/home/share /SRV_BACKUPS1/NEW_BACKUPS/MSILOVA/d
rsync $BKP_CMD_OPTS root@$MSILOVA:/home/tmitkova/Desktop/SN /SRV_BACKUPS1/NEW_BACKUPS/MSILOVA/d
rsync $BKP_CMD_OPTS root@$MSILOVA:/home/tmitkova/Documents /SRV_BACKUPS1/NEW_BACKUPS/MSILOVA/d

sleep 1

##daily backup spisheva - Mercer
rsync $BKP_CMD_OPTS root@$SPISHEVA:/home/share /SRV_BACKUPS1/NEW_BACKUPS/SPISHEVA/d
rsync $BKP_CMD_OPTS root@$SPISHEVA:/home/spisheva/Desktop/Formation_elements /SRV_BACKUPS1/NEW_BACKUPS/SPISHEVA/d
rsync $BKP_CMD_OPTS root@$SPISHEVA:/home/spisheva/00_Organisation_journaliere /SRV_BACKUPS1/NEW_BACKUPS/SPISHEVA/d

sleep 1

####daily backup tpenerlieva - IPECA
rsync $BKP_CMD_OPTS root@$TPENERLIEVA:/home/share /SRV_BACKUPS1/NEW_BACKUPS/TPENERLIEVA/d
rsync $BKP_CMD_OPTS root@$TPENERLIEVA:/home/tpenerlieva /SRV_BACKUPS1/NEW_BACKUPS/TPENERLIEVA/d

####daily backup vtotov - Santiane

rsync $BKP_CMD_OPTS root@$VTOTOV:/home/vtotov /SRV_BACKUPS1/NEW_BACKUPS/VTOTOV/d


########daily backup tdjambova - Santiane

rsync $BKP_CMD_OPTS root@$TDJAMBOVA:/home/tdjambova /SRV_BACKUPS1/NEW_BACKUPS/TDJAMBOVA/d
