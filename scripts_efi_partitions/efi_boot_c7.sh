mount /dev/sda1 /boot/efi/

sleep 1

mount /dev/sdb2 /mnt

sleep 1

rsync -avz /mnt/boot /

if [ $? -ne 0 ]
then
    echo "Error copying EFI dir"
    exit 200
else
    echo "Done copying EFI dir"
fi

sleep 1

ntpdate time.obs-02.local

sleep 2

hwclock -w

sleep 1

vi /etc/hostname 

sleep 1

cd && umount -a 

sleep 1

exit
