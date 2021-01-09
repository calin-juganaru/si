sudo brctl addbr virbr0
sudo brctl addif virbr0 ens33
sudo ip address flush dev ens33
sudo dhclient virbr0

echo 'allow virbr0' | sudo tee -a /etc/qemu/bridge.conf

sudo qemu-system-arm -machine versatilepb -cpu arm1176 -kernel zImage-qemu \
     -append 'root=/dev/sda2' -drive file=2015-05-05-raspbian-wheezy-qemu.img,index=0,media=disk,format=raw \
     -net nic,model=smc91c111,netdev=bridge -netdev bridge,br=virbr0,id=bridge -serial stdio

sudo ip a f eth0 && sudo ip add add 169.254.10.242/16 dev eth0

sudo ip add flush dev eth0
sudo ip add add 10.0.2.16/24 dev eth0
sudo ip route add default via 10.0.2.2

echo 'deb http://legacy.raspbian.org/raspbian wheezy main contrib non-free' | sudo tee -a /etc/apt/sources.list

sudo apt-get update
sudo apt-get install vim

sudo apt-get install lighttpd php5-cgi

sudo lighty-enable-mod cgi
sudo /etc/init.d/lighttpd force-reload
sudo netstat -tlnp | grep 80
sudo ps ax -f | grep lighttpd

date +"Today is: %A %d %B"

sudo mv /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.old
sudo vim /etc/lighttpd/lighttpd.conf
sudo /etc/init.d/lighttpd force-reload

sudo lighty-enable-mod fastcgi-php
php-cgi -v
which php-cgi
sudo /etc/init.d/lighttpd force-reload