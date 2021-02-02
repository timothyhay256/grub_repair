read -p "Enter the path to the boot partition." boot_part
read -p "Enter the path to the drive." drive_pth
sudo mkdir /mnt/chrootdir
sudo mount boot_part /mnt/chrootdir || echo The boot partition could not be mounted. Exiting && exit(1)
sudo umount boot_part
sudo mount drive_pth /mnt/chrootdir || echo The drive could not be mounted. Exiting && exit(1)
sudo umount drive_pth

sudo umount /mnt/chrootdir
sudo rm -rf /mnt/chrootdir
sudo mkdir /mnt/chrootdir
sudo mount boot_part /mnt/chrootdir
for dir in proc dev sys etc bin sbin var usr lib lib64 tmp; do
    sudo mkdir /mnt/chrootdir/$dir && sudo mount --bind /$dir /mnt/chrootdir/$dir
done
chroot /mnt/chrootdir
grub-install drive_pth # May not be required
update-grub2
echo Done.
