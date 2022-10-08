#!/bin/bash

#parted -a optimal -s /dev/sda \
#	mklabel msdos\
#	mklabel gpt \
#	mkpart primary fat32 1MiB 500MiB \
#	mkpart primary ext4 500MiB 108GiB \
#	mkpart primary linux-swap 108GiB 100% \
#	set 1 esp on 
#sleep 1

#mkfs.vfat -F32 /dev/sda1
#mkfs.ext4 /dev/sda2
#mkswap /dev/sda3


(echo g; echo n; echo; echo;  echo 1024000; echo No; echo t; echo 1; echo n; echo; echo; echo 226203906; echo n; echo; echo; echo; echo t; echo; echo 19; echo w) | fdisk /dev/sda 
mkfs.vfat -F32 /dev/sda1                                                                                 
mkfs.ext4 /dev/sda2                                                                                      
mkswap /dev/sda3
