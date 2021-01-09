#!/bin/bash

sudo vmhgfs-fuse .host:/shared /mnt/hgfs/ -o allow_other -o uid=1000

sudo brctl addbr virbr0
sudo brctl addif virbr0 ens33
sudo ip address flush dev ens33
sudo dhclient virbr0

export PATH="/mnt/hgfs/tools/arm-bcm2708/arm-linux-gnueabihf/bin:$PATH"

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j4
