#!/bin/bash

parted -a optimal -s /dev/sda \
	mklabel gpt \
	mkpart primary fat32 1MiB 500MiB \
	set 1 esp on \
	mkpart primary ext4 500MiB 108GiB \
	mkpart primary linux-swap 108GiB 100%

sleep 1

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3


mount /dev/sda2 /media/

sleep 1

#rsync -avz /mnt/bin /mnt/boot /mnt/dev /mnt/etc /mnt/home /mnt/lib /mnt/lib64 /mnt/media /mnt/mnt /mnt/opt /mnt/proc /mnt/root /mnt/run /mnt/sbin /mnt/srv /mnt/sys /mnt/tmp /mnt/usr /mnt/var /media/

rsync -avz /mnt/* /media/

sleep 1

mkdir /media/dev

sleep 1

mount --bind /dev/ /media/dev/
mount --bind /proc/ /media/proc/
mount --bind /sys/ /media/sys/

sleep 1

chroot /media/
