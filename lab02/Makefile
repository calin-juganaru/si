CC = ../tools/arm-bcm2708/arm-bcm2708hardfp-linux-gnueabi/bin/arm-bcm2708hardfp-linux-gnueabi-
CFLAGS = -static -std=c++11
CCC = ../tools/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
OBD = ../tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-

IMAGE = ../VM/zImage-qemu
FILE = ../VM/raspbian.img
QFLAGS = -machine versatilepb -cpu arm1176

build: unu.cpp
	./$(CC)g++ $(CFLAGS) $^ -o unu
	qemu-arm -cpu arm1176 unu

doi:
	sudo qemu-system-arm -$(QFLAGS) -kernel $(IMAGE) \
	-append 'root=/dev/sda2' \
	-drive file=$(FILE),index=0,media=disk,format=raw \
	-net nic,model=smc91c111,netdev=bridge \
	-netdev bridge,br=virbr0,id=bridge -serial stdio

patru: unu.cpp
	$(COMP)g++ $(CFLAGS) $^ -o unu

sase: unu
    $(OBD)objdump unu

clean:
	rm -f unu
