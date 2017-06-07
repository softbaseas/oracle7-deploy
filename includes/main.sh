#!/bin/bash

source ./includes/setVars.sh

echo "";

echo "Choose one of the following possibilities:"
echo " 1 - Setup Network"
echo " 2 - Change Hosts Files"
echo " 3 - Change Formsweb"
echo " 4 - Start Admin Server using Nodemanager"
#echo " 4 - Change Oracle vHosts"
#echo " 5 - Configure ORDS"
#echo " 6 - Generate SSL Certificates using Lets Encrypt"
#echo " 7 - Setup Lets Encrypt Automatic Renewal"
#echo " 8 - Create Apache (httpd) virtual hosts"
#echo " full - Full Configuration"
echo " q - Exit"

while true; do
    read -p "Choice: " choice
    case $choice in
      [1]*) # Setup network
        if [ -z "$fqdn" ]; then getFQDN; fi
        if [ -z "$ip" ]; then getIP; fi
        ./includes/linux/setup_network.sh $fqdn $internalIP $externalIP;;
      [2]*) # Setup /etc/hosts
        if [ -z "$fqdn" ]; then getFQDN; fi
        if [ -z "$ip" ]; then getIP; fi
        ./includes/linux/setup_hosts.sh $fqdn $subdomain $externalIP;;
      [3]*) # Configure formsweb
        if [ -z "$fqdn" ]; then getFQDN; fi
        ./includes/oracle/formsweb.sh $fqdn;;
      [4]*) # Start adminserver using nodemanager
        ./includes/oracle/nodemanager.sh ;;
      [q]*) echo "Exiting"; break;;
    esac
done
