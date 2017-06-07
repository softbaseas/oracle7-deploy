#!/bin/bash

# $1 = fqdn
# $2 = subdomain
# $3 = ip

fqdn=$1;
subdomain=$2
externalIP=$3;

# The following line a the following lines added together:
# Remove all lines including 'changefmw': sed "s/\S*\(sbsv12l6master\)\S*//g" /etc/hosts
# Add FQDN to the loop line             : sed "/^#127.0.0.1/ s/$/ $1/" /etc/hosts
# Add FQDN to the external IP           : sed "/^#10.174.234.99/ s/$/ $1/" /etc/hosts
# Change the external IP address        : sed "s/10.174.234.99/10.174.234.$2/" /etc/hosts
sed -e "/sbsv12l6master/c sbsv12l6master.softbase.dk\tsbsv12l6master\t$externalIP\t$fqdn\t$subdomain" /etc/hosts > ./new_hosts.txt
#sed -e "s/\S*\(sbsv12l6master\)\S*//g" -e "/^#127.0.0.1/ s/$/ $fqdn/" -e "/^#10.174.234.98/ s/$/ $fqdn/" -e "s/10.174.234.98/$externalIP/" /etc/hosts > ./new_hosts.txt
mv /etc/hosts /etc/hosts.org
mv ./new_hosts.txt /etc/hosts

echo "Created new hosts file."

# To fix the SELinux Shit:
#chcon -R -h -t httpd_sys_script_exec_t /etc/hosts
