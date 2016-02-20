#!/bin/bash
 
DIRECTORY=img
 
if [ -d "$DIRECTORY" ]; then
        rm -fr $DIRECTORY
fi
 
mkdir $DIRECTORY || exit
mkdir -m 755 $DIRECTORY/dev
mknod -m 600 $DIRECTORY/dev/console c 5 1
mknod -m 600 $DIRECTORY/dev/initctl p
mknod -m 666 $DIRECTORY/dev/full c 1 7
mknod -m 666 $DIRECTORY/dev/null c 1 3
mknod -m 666 $DIRECTORY/dev/ptmx c 5 2
mknod -m 666 $DIRECTORY/dev/random c 1 8
mknod -m 666 $DIRECTORY/dev/tty c 5 0
mknod -m 666 $DIRECTORY/dev/tty0 c 4 0
mknod -m 666 $DIRECTORY/dev/urandom c 1 9
mknod -m 666 $DIRECTORY/dev/zero c 1 5
 
test -d /etc/yum && yum --installroot=$PWD/$DIRECTORY --releasever=/ --setopt=tsflags=nodocs \
--setopt=group_package_types=mandatory -y install bash yum vim-minimal
test -d /etc/yum && cp -a /etc/yum* /etc/rhsm/* /etc/pki/* $DIRECTORY/etc/
 
test -d /etc/zypp && zypper --root $PWD/$DIRECTORY  -D /etc/zypp/repos.d/ \
--no-gpg-checks -n install -l bash zypper vim python
test -d /etc/zypp && cp -a /etc/zypp* /etc/products.d $DIRECTORY/etc/
 
rm -fr $DIRECTORY/usr/{{lib,share}/locale,{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive}
rm -fr $DIRECTORY/usr/share/{man,doc,info,gnome/help}
rm -fr $DIRECTORY/usr/share/cracklib
rm -fr $DIRECTORY/usr/share/i18n
rm -fr $DIRECTORY/etc/ld.so.cache
rm -fr $DIRECTORY/var/cache/ldconfig/*
