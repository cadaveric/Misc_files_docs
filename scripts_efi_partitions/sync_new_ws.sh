#!/bin/bash

mount /dev/sda2 /media/

sleep 1

rsync -avz /mnt/* /media/

sleep 1

[ ! -d /media/dev ] && mkdir /media/dev
[ ! -d /media/proc ] && mkdir /media/proc
[ ! -d /media/sys ] && mkdir /media/sys

sleep 1

if ls /media/sda* 1> /dev/null 2>&1; then
    
    rsync -avz /mnt/* /media/

    sleep 1

    [ ! -d /media/dev ] && mkdir /media/dev
    [ ! -d /media/proc ] && mkdir /media/proc
    [ ! -d /media/sys ] && mkdir /media/sys
fi

sleep 1

mount --bind /dev /media/dev
mount --bind /proc /media/proc
mount --bind /sys /media/sys

sleep 1

chroot /media

