DESCRIPTION = "Fuego, impodobitorul de brazi"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://fuego.cpp \
	   file://index.html \
	   file://script.php \
          "

do_image_prepend() {
    bb.warn("The image 'rpi-basic-image' is deprecated, please use 'core-image-base' instead")
}

do_compile () {
    ${CC} -lstdc++ -std=c++14 -Os ${WORKDIR}/fuego.cpp -lncurses -o ${WORKDIR}/fuego
}

do_install () {
    install -d ${D}${bindir}

    install -m 0755 -t ${D}${bindir} ${WORKDIR}/fuego

    mkdir -p ${D}/www/pages/
    cp ${WORKDIR}/index.html ${D}/www/pages/
    cp ${WORKDIR}/script.php ${D}/www/pages/
}

FILES_${PN} += "/www/pages"
