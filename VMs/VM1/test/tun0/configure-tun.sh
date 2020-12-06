#!/bin/bash

if [ $# != 1 ]; then
	echo "This script needs the name of the interface to setup."
	exit 1
fi

NETMASK="64"

#echo " Setting up ipv6 addr and netmask..."
ip -6 address add fc00:1234:ffff::1/${NETMASK} dev $1
ip -6 link set $1 up