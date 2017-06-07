#!/bin/bash
#echo -n "Password for database user sys: "
#read -s sys_pwd

sys_pwd=$1;

# Switch user and set environment
su - oracle
. ./ofr12c.sh
cd /Oracle/Middleware12c/apex/

# Execute SQL Script
sqlplus sys@ottostest as sysdba @apex_rest_config.sql << END
$sys_pwd
$1
$1
exit;
END

echo "RESTful has ben configured."

# exit (go back to root user)
exit
