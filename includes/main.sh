#!/bin/bash

source ./includes/setVars.sh

echo "";

echo "Choose one of the following possibilities:"
echo " 1 - Setup Network"
#echo " 2 - Change Hosts Files"
#echo " 3 - Change Formsweb"
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
      [1]*)
        if [ -z "$fqdn" ]; then getFQDN; fi
        if [ -z "$ip" ]; then getIP; fi
        echo "sub=$subdomain";;
        #./includes/linux/setup_network.sh $fqdn $internalIP $externalIP;;
      [q]*) echo "Exiting"; break;;
    esac
done
