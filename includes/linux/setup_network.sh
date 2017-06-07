#!/bin/bash

hostname=$1
external=$2;
internal=$3;

echo "Hostname = $hostname"
echo "External = $external"
echo "Internal = $internal"

nmcli g hostname $fqdn
nmcli con mod eth0 ipv4.addr $external ipv4.gateway 10.174.234.1
nmcli con mod eth1 ipv4.addr $internal

echo "Network has been changed."

echo;

#echo "Changing hosts file..."
#./includes/change_hosts.sh "$1" "$ip"
