#!/bin/bash

source ./includes/setVars.sh

while true; do
    echo "";
    echo "Choose one of the following possibilities:"
    echo " 0 - Stop webnm"
    echo " 1 - Setup network"
    echo " 2 - Change hosts files"
    echo " 3 - Change formsweb"
    echo " 4 - Change Oracle virtual hosts"
    echo " 5 - Deploy ORDS (prerequisite: ORDS already configured)"
    echo " 6 - Generate SSL certificates using Lets Encrypt"
    echo " 7 - Setup Lets Encrypt automatic renewal"
    echo " 8 - Create Apache (httpd) virtual hosts"
    echo " 9 - Create nodemanager Service"
    #echo " a - Start webnm" # Removed because it has to be started from web first time
    echo " a - Start admin server using Nodemanager"
    #echo " full - Full Configuration"
    echo " q - Exit"
    read -p "Choice: " choice
    case $choice in
      [0]* ) # Stop webm service
        echo "Stopping. Can take several minutes..."
        systemctl stop webnm
        systemctl status webnm;;
      [1]* ) # Setup network
        if [ -z "$fqdn" ]; then getFQDN; fi
        if [ -z "$ip1" ]; then getIP; fi
        ./includes/linux/setup_network.sh $fqdn $externalIP $internalIP;;
      [2]* ) # Setup /etc/hosts
        if [ -z "$fqdn" ]; then getFQDN; fi
        if [ -z "$ip1" ]; then getIP; fi
        ./includes/linux/setup_hosts.sh $fqdn $subdomain $externalIP;;
      [3]* ) # Configure formsweb
        if [ -z "$fqdn" ]; then getFQDN; fi
        ./includes/oracle/formsweb.sh $fqdn;;
      [4]* ) # Change Oracle vhosts
        if [ -z "$fqdn" ]; then getFQDN; fi
        ./includes/oracle/vhosts.sh $fqdn;;
      [5]* ) # configure ords
        ./includes/oracle/ords.sh;;
      [6]* ) # Generate SSL Certificates using Lets Encrypt
        if [ -z "$fqdn" ]; then getFQDN; fi
        ./includes/linux/letsencrypt.sh $fqdn;;
      [7]* ) # Enable Lets Encrypt Automatic Renewal
        ./includes/linux/le-autorenew.sh;;
      [8]* ) # Create httpd vHosts
        if [ -z "$fqdn" ]; then getFQDN; fi
        ./includes/linux/apache_add_vhost.sh $fqdn;;
      [9]* ) # create nodemanager service
        ./includes/oracle/nodemanager_service.sh;;
      #[a]* ) # Start webnm
      #  echo "Starting. Can take several minutes..."
      #  systemctl start webnm
      #  systemctl status webnm;;
      [a]* ) # Start adminserver using nodemanager
        ./includes/oracle/nodemanager.sh ;;
      [q]* ) echo "Exiting"; break;;
    esac
done
