#!/bin/bash
echo "Please ensure you have built initrd using gen_initrd, before executing, If not, please ctrl^c now"
sudo umount mnt
sudo mount ../build/floppy.img mnt
sudo cp ../build/xitox.kern mnt/kernel
sudo cp ../build/initrd.img mnt/initrd
sync
sudo umount mnt
