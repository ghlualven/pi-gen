#!/bin/bash -e

# run tomcat9 as root
sed -i "s/User=tomcat/User=root/g" "${ROOTFS_DIR}/lib/systemd/system/tomcat9.service"
sed -i "s/Group=tomcat/Group=root/g" "${ROOTFS_DIR}/lib/systemd/system/tomcat9.service"