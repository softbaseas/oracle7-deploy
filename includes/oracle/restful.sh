#!/bin/bash
read -p "Database for rest config: " database
echo -n "Password for database user sys: "
read -s sys_pwd
#sys_pwd=$1;

# Switch user and set environment
su - oracle
. ./ofr12c.sh
cd /Oracle/Middleware12c/apex/

# Execute SQL Script
sqlplus sys@$database as sysdba @apex_rest_config.sql << END
$sys_pwd
$1
$1
exit;
END

echo "RESTful has ben configured."
