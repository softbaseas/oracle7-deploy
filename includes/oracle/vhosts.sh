#!/bin/bash
fqdn=$1;

sed "s/sbsv12l6master.softbase.dk/$fqdn/" /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/config.xml > new_config.xml
mv /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/config.xml /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/config.xml.original
mv new_config.xml /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/config.xml

echo "Virtual Hosts added to Oracle."
