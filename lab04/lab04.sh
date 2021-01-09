#!/bin/bash

dd if=/dev/zero of=full.img bs=1 count=0 seek=6G
echo -ne "n\np\n1\n\n+100M\nn\np\n2\n\n\nw\n" | fdisk full.img
dd if=/dev/zero of=boot.img bs=1 count=0 seek=100M
mkfs.vfat boot.img
dd if=/dev/zero of=rootfs.img bs=1 count=0 seek=6G
mkfs.ext2 rootfs.img
dd if=boot.img of=full.img seek=2048
dd if=rootfs.img of=full.img seek=206848

mkdir mp_source
mkdir mp_dest
sudo mount ../../VM/raspbian.img -o offset=$((122880 * 512)) mp_source/
#sudo sync
sudo mount full.img -o offset=$((206848 * 512)) mp_dest/
sudo cp -a mp_source/* mp_dest/

sudo qemu-system-arm -machine versatilepb -cpu arm1176 \
     -kernel ../../VM/zImage-qemu -append "root=/dev/sda2" \
     -drive file=full.img,index=0,media=disk,format=raw -serial stdio