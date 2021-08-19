#!/bin/bash -e

install -m 644 files/sources.list "${ROOTFS_DIR}/etc/apt/"
install -m 644 files/raspi.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/raspi.list"

if [ -n "$APT_PROXY" ]; then
	install -m 644 files/51cache "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
	sed "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache" -i -e "s|APT_PROXY|${APT_PROXY}|"
else
	rm -f "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
fi

#so debootstrap just extracts the *.deb's, so lets clean this up hackish now,
#but then allow dpkg to delete these extra files when installed later..
rm -rf "${ROOTFS_DIR}/usr/share/locale/*"
rm -rf "${ROOTFS_DIR}/usr/share/man/*"
rm -rf "${ROOTFS_DIR}/usr/share/doc/*"

#dpkg, No Docs...
install -m 644 files/01_nodoc "${ROOTFS_DIR}/etc/dpkg/dpkg.cfg.d/"
#apt: no local cache
install -m 644 files/02nocache "${ROOTFS_DIR}/etc/apt/apt.conf.d/"
#apt: drop translations...
install -m 644 files/02translations "${ROOTFS_DIR}/etc/apt/apt.conf.d/"
#apt: emulate apt-get clean:
install -m 644 files/02apt-get-clean "${ROOTFS_DIR}/etc/apt/apt.conf.d/"
#apt: no PDiffs..
install -m 644 files/02no-pdiffs "${ROOTFS_DIR}/etc/apt/apt.conf.d/"
#apt: /var/lib/apt/lists/, store compressed only
install -m 644 files/02compress-indexes "${ROOTFS_DIR}/etc/apt/apt.conf.d/"

on_chroot apt-key add - < files/raspberrypi.gpg.key
on_chroot << EOF
apt-get update
apt-get dist-upgrade -y
EOF
