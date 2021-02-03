sudo rm -rf /mnt/chrootdir
sudo mkdir /mnt/chrootdir
sudo mount /dev/sda4 /mnt/chrootdir
for dir in proc dev sys etc bin sbin var usr lib lib64 tmp; do
    sudo mkdir /mnt/chrootdir/$dir && sudo mount --bind /$dir /mnt/chrootdir/$dir
done
chroot /mnt/chrootdir
grub-install /dev/sda # May not be required
update-grub2
