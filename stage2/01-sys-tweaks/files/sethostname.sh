#!/bin/sh

get_hostname() {
    cat /etc/hostname | tr -d " \t\n\r"
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

# get_fsmode() {
# 	mount | sed -n -e "s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p"
# }

CURRENT_HOSTNAME=$(get_hostname)
#echo "Current hostname: $CURRENT_HOSTNAME"

prefix="ABC"
NEW_HOSTNAME=$prefix-$(get_eth0_mac_2)
#echo "New hostname: $NEW_HOSTNAME"

if [ "${CURRENT_HOSTNAME}" != "${NEW_HOSTNAME}"  ]; then
	# fsmode=$(get_fsmode)
	# if [ $fsmode = "ro" ]; then
	# 	mount -o remount,rw /
	# fi
	
	echo ${NEW_HOSTNAME} > /etc/hostname
	sed -i "s/127.0.1.1.*${CURRENT_HOSTNAME}/127.0.1.1\t${NEW_HOSTNAME}/g" /etc/hosts
	hostname ${NEW_HOSTNAME}
	
	# if [ $fsmode = "ro" ]; then
	# 	mount -o remount,ro /
	# fi

	# shutdown -r now
	echo "Hostname changed to ${NEW_HOSTNAME}!!"
else
        echo "Hostname no change!!"
fi
