CC = ./bin/arm-linux-gnueabihf-g++
CFLAGS = -static -std=c++14

IMAGE = ../SI\ VM/zImage-qemu
FILE = ../SI\ VM/raspbian.img
QFLAGS = -machine versatilepb -cpu arm1176

build: unu.cpp
	$(CC) $(CFLAGS) $^ -o unu
	qemu-arm -cpu arm1176 unu

clean:
	rm -f unu

trei:
	qemu-system-arm $(QFLAGS) -kernel $(IMAGE) -append "root=/dev/sda2" -drive file=$(FILE),index=0,media=disk,format=raw

patru:
	qemu-system-arm $(QFLAGS) -kernel $(IMAGE) -append "root=/dev/sda2" -drive file=$(FILE),index=0,media=disk,format=raw -serial stdio

cinci:
	qemu-system-arm $(QFLAGS) -kernel $(IMAGE) -append "root=/dev/sda2 console=ttyAMA0 console=tty1" -drive file=$(FILE),index=0,media=disk,format=raw -serial stdio
