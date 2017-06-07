#!/bin/bash

hostname=$1
external=$2;
internal=$3;

read -p "Gateway ip: " gateway
read -p "DNS1: " dns1
read -p "DNS2: " dns2

echo "Hostname = $hostname"
echo "External = $external"
echo "Internal = $internal"

nmcli g hostname $fqdn
nmcli con mod eth0 ipv4.addr $external ipv4.gateway $gateway ipv4.dns "$dns1 $dns2"
nmcli con mod eth1 ipv4.addr $internal

hostname $fqdn;
hostnamectl set-hostname $fqdn

echo "Network has been changed."

echo;

#echo "Changing hosts file..."
#./includes/change_hosts.sh "$1" "$ip"
