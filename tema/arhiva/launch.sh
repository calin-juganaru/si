#!/bin/bash

sudo dhclient -r
sudo brctl addbr virbr0
sudo brctl addif virbr0 eth0
sudo ip a f dev eth0
sudo dhclient virbr0

sudo qemu-system-arm -machine versatilepb -cpu arm1176 -kernel ./zImage \
	-append "root=/dev/sda rw" \
	-net nic,model=smc91c111,netdev=bridge \
	-netdev bridge,br=virbr0,id=bridge \
	-hda ./rpi-fuego-image-raspberrypi.ext3
