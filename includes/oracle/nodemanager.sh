#!/bin/bash

read -p "Enter nodemanager username: " username
read -p "Enter nodemanager password: " password

su - oracle /home/oracle/Oracle/Middleware12c/ofr1/oracle_common/common/bin/wlst.sh << EOF > /tmp/nodemanager.log
nmConnect($username,$password,'localhost','5556','SBErpc12','/home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12')
prps = makePropertiesObject("AdminURL=http://ottos12.softbase.ch;7001;Username=$username;Password=$password;weblogic.ListenPort=7001")
nmStart("AdminServer", props=prps)
exit()
EOF

echo "Aadminserver configured";
