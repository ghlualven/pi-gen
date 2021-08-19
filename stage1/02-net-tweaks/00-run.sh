#!/bin/bash -e

get_wlan0_mac_0() {
    ifconfig wlan0 | awk '/ether/{print toupper($2)}'
}

get_wlan0_mac_1() {
    echo $(get_wlan0_mac_0) | awk -F: '{print $1 $2 $3 $4 $5 $6}'
}

get_wlan0_mac_2() {
    echo $(get_wlan0_mac_0) | awk -F: '{print $4 $5 $6}'
}

get_eth0_mac_0() {
    ifconfig eth0 | awk '/ether/{print toupper($2)}'
}

get_eth0_mac_1() {
    echo $(get_eth0_mac_0) | awk -F: '{print $1 $2 $3 $4 $5 $6}'
}

get_eth0_mac_2() {
    echo $(get_eth0_mac_0) | awk -F: '{print $4 $5 $6}'
}

TARGET_HOSTNAME=${TARGET_HOSTNAME}-$(get_eth0_mac_2)

echo "${TARGET_HOSTNAME}" > "${ROOTFS_DIR}/etc/hostname"
echo "127.0.1.1		${TARGET_HOSTNAME}" >> "${ROOTFS_DIR}/etc/hosts"

ln -sf /dev/null "${ROOTFS_DIR}/etc/systemd/network/99-default.link"
