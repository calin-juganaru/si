require recipes-core/images/rpi-basic-image.bb

IMAGE_INSTALL += "avahi-daemon lighttpd lighttpd-module-fastcgi php-cgi fuego"
