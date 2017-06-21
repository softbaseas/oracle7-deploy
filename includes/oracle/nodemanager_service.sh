#!/bin/sh
#SCRIPT=$(readlink -f $0)
#SCRIPT_PATH=$(dirname $SCRIPT)

ORACLE_INSTALL_USER="oracle"
ORACLE_INSTALL_GROUP="oinstall"
DOMAIN_CONFIGURATION_HOME="/home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12"
NODE_MANAGER_HOME="/home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/nodemanager"

touch /etc/systemd/system/nodemanager.service
chmod u+x /etc/systemd/system/nodemanager.service

echo "[Unit]
Description=Node Manager controls the WebLogic Server runtime lifecycle
After=network.target
[Service]
User=$ORACLE_INSTALL_USER
Group=$ORACLE_INSTALL_GROUP
Type=simple
ExecStart=$DOMAIN_CONFIGURATION_HOME/bin/startNodeManager.sh >/dev/null 2>/dev/null &
ExecStop=$DOMAIN_CONFIGURATION_HOME/bin/stopNodeManager.sh >/dev/null 2>/dev/null &
PIDFile=$NODE_MANAGER_HOME/nodemanager.process.id
Restart=on-failure
RestartSec=1
[Install]
WantedBy=default.target" > /etc/systemd/system/nodemanager.service

systemctl daemon-reload
systemctl enable nodemanager.service
systemctl start nodemanager.service
