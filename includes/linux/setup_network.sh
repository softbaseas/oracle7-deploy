#!/bin/bash

fqdn=$1
external=$2;
internal=$3;

read -p "Gateway ip (eth0): " gateway
read -p "DNS1 (eth0): " dns1
read -p "DNS2 (eth0): " dns2

echo "Hostname = $fqdn"
echo "External = $external"
echo "Internal = $internal"

nmcli g hostname $fqdn
nmcli con mod eth0 ipv4.addr $external/24 ipv4.gateway $gateway ipv4.dns "$dns1 $dns2"
nmcli con mod eth1 ipv4.addr $internal/24

hostname $fqdn;
hostnamectl set-hostname $fqdn

echo "Network has been changed."

echo "Do \"systemctl restart network\" and connect to the new ip address."

echo;

#echo "Changing hosts file..."
#./includes/change_hosts.sh "$1" "$ip"
