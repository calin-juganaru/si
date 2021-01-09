#!/bin/bash

PATH="/home/osboxes/Desktop"

sudo apt install python texinfo gawk chrpath libsdl1.2-dev libtool sed wget cvs \
    subversion git-core coreutils unzip texi2html docbook-utils python-pysqlite2 \
    diffstat help2man make gcc build-essential g++ desktop-file-utils \
    libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake groff xterm

git clone git://git.yoctoproject.org/poky
cd ./poky
git checkout b8631416f12b8a904ce3deb036f9d5ce632937b0
git clone git://git.yoctoproject.org/meta-raspberrypi
cd ./meta-raspberrypi
git checkout 6c6f44136f7e1c97bc45be118a48bd9b1fef1072
cd ..
mkdir build
source oe-init-build-env ./build/
echo 'MACHINE = "raspberrypi"' | tee -a ./conf/local.conf
echo 'BB_NUMBER_THREADS = "4"' | tee -a ./conf/local.conf
echo 'PARALLEL_MAKE = "-j4"'   | tee -a ./conf/local.conf
nano  ./conf/bblayers.conf # add '/home/osboxes/Desktop/poky/meta-raspberrypi \'

touch /home/osboxes/Desktop/poky/build/tmp/work/x86_64-linux/automake-native/1.14.1-r0/automake-1.14.1/doc/automake-1.14.1
touch /home/osboxes/Desktop/poky/build/tmp/work/x86_64-linux/automake-native/1.14.1-r0/automake-1.14.1/doc/aclocal-1.14.1

pluma /home/osboxes/Desktop/poky/build/tmp/sysroots/x86_64-linux/usr/bin/automake # 3930: s/\$\{([^ \t=:+{}]+)\}
pluma /home/osboxes/Desktop/poky/build/tmp/sysroots/x86_64-linux/usr/bin/automake-1.14

rm -f ./tmp/work/x86_64-linux/ncurses-native/5.9-r15.1/ncurses-5.9/ncurses/base/MKlib_gen.sh
cp /mnt/hgfs/lab06/MKlib_gen.sh ./tmp/work/x86_64-linux/ncurses-native/5.9-r15.1/ncurses-5.9/ncurses/base/MKlib_gen.sh

nano /home/osboxes/Desktop/poky/meta/recipes-core/ncurses/ncurses.inc # --without-cxx-binding \

nano ../meta/recipes-devtools/elfutils/elfutils_0.160.bb
CFLAGS_class-native += " -Wno-error=misleading-indentation"
CFLAGS_class-nativesdk += " -Wno-error=misleading-indentation"
CFLAGS_class-native += " -Wno-error=nonnull-compare"
CFLAGS_class-nativesdk += " -Wno-error=nonnull-compare"
CFLAGS_class-native += " -Wno-error=implicit-fallthrough"
CFLAGS_class-nativesdk += " -Wno-error=implicit-fallthrough"
CFLAGS_class-native += " -Wno-error=format-truncation"
CFLAGS_class-nativesdk += " -Wno-error=format-truncation"
CFLAGS_class-native += " -Wno-error"
CFLAGS_class-nativesdk += " -Wno-error"

pluma ../meta/recipes-devtools/binutils/binutils_2.24.bb
CFLAGS_class-native += " -Wno-error"
CFLAGS_class-nativesdk += " -Wno-error"

pluma ./tmp/work/x86_64-linux/glib-2.0-native/1_2.40.0-r0/glib-2.40.0/glib/gdate.c # linia 2500
# #pragma GCC diagnostic push
# #pragma GCC diagnostic ignored "-Wformat-nonliteral"
# tmplen = strftime (tmpbuf, tmpbufsize, locale_format, &tm);
# #pragma GCC diagnostic pop

pluma /home/osboxes/Desktop/poky/build/tmp/work-shared/gcc-4.9.1-r0/gcc-4.9.1/gcc/cp/Make-lang.in
# gperf -o -C -E -k '1-6,$$' -j1 -D -N 'libc_name_p' -L C++ \

pluma /home/osboxes/Desktop/poky/build/tmp/work-shared/gcc-4.9.1-r0/gcc-4.9.1/gcc/cp/cfns.gperf
# %language=C++
# %define class-name libc_name

pluma /home/osboxes/Desktop/poky/build/tmp/work-shared/gcc-4.9.1-r0/gcc-4.9.1/gcc/cp/cfns.h
# class libc_name
# {
# private:
#   static inline unsigned int hash (const char *str, unsigned int len);
# public:
#   static const char *libc_name_p (const char *str, unsigned int len);
# };
#
# inline unsigned int
# libc_name::hash (register const char *str, register unsigned int len)
# ...
# libc_name::libc_name_p (register const char *str, register unsigned int len)

pluma /home/osboxes/Desktop/poky/build/tmp/work-shared/gcc-4.9.1-r0/gcc-4.9.1/gcc/cp/except.c # linia 1033
# return !!libc_name::libc_name_p (IDENTIFIER_POINTER (id),
#                                  IDENTIFIER_LENGTH (id));

pluma /home/osboxes/Desktop/poky/meta/recipes-core/glibc/cross-localedef-native_2.20.bb
# linia 46: CFLAGS += "-DNOT_IN_libc=1 -fgnu89-inline"

pluma /home/osboxes/Desktop/poky/meta/recipes-core/glibc/cross-localedef-native_2.20.bb

bitbake rpi-basic-image

wget http://cs.curs.pub.ro/wiki/si/_media/lab/2014/yocto/kernel.zip
unzip kernel.zip
