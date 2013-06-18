#!/bin/bash
sudo umount mnt2
sudo /sbin/losetup /dev/loop7 build/floppy.img
sudo mount /dev/loop7 mnt2
sudo cp build/xitox.kern mnt2/kernel
sudo cp build/initrd.img mnt2/initrd
sudo umount mnt2
sudo /sbin/losetup -d /dev/loop7
