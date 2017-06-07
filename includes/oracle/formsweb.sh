#!/bin/bash
fqdn=$1;

# Change fqdn in forms cfg file
sed "s/changefmw.softbase.dk/$fqdn/" /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg > ./new_formsweb.cfg
mv /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg.original
mv ./new_formsweb.cfg /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg

# Change fqdn in domain config.xml
sed "s/changefmw.softbase.dk/$fqdn/" /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/config.xml > ./new_config.xml
mv /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/config.xml /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/config.xml.original
mv ./new_config.xml /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/config.xml

chown oracle:oinstall /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg
chown oracle:oinstall /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg.original
chown oracle:oinstall /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/config.xml
chown oracle:oinstall /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/config.xml.original

echo "Changes made in formsweb."
