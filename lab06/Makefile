IMAGE = ../lab03/linux/arch/arm/boot/zImage
FILE = ./poky/build/tmp/deploy/images/raspberrypi/rpi-basic-image-raspberrypi.ext3
QFLAGS = -machine versatilepb -cpu arm1176

unu:
	qemu-system-arm -$(QFLAGS) -kernel $(IMAGE) \
	-append "root=/dev/sda rw" -hda $(FILE)