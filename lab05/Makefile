IMAGE = ../VM/zImage-qemu
FILE = ./qemu.img
QFLAGS = -machine versatilepb -cpu arm1176

run:
	sudo qemu-system-arm -$(QFLAGS) -kernel $(IMAGE) \
	-append 'root=/dev/sda2' \
	-drive file=$(FILE),index=0,media=disk,format=raw \
    -net nic,model=smc91c111,netdev=bridge -netdev bridge,br=virbr0,id=bridge \
	-serial stdio