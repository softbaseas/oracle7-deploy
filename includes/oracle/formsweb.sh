#!/bin/bash
fqdn=$1;

sed "s/sbsv12l6master.softbase.dk/$fqdn/" /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg > ./new_formsweb.cfg
mv /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg.original
mv ./new_formsweb.cfg /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/servers/WLS_FORMS/applications/formsapp_12.2.1/config/formsweb.cfg

echo "Changes made in formsweb."
