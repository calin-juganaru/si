IMAGE = ./zImage
FILE = ../VM/raspbian.img
QFLAGS = -machine versatilepb -cpu arm1176

run:
	sudo qemu-system-arm -$(QFLAGS) -kernel $(IMAGE) \
	-append 'root=/dev/sda2' \
	-drive file=$(FILE),index=0,media=disk,format=raw \
	-serial stdio
