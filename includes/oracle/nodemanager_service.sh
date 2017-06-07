#!/bin/sh
SCRIPT=$(readlink -f $0)
SCRIPT_PATH=$(dirname $SCRIPT)

. ${SCRIPT_PATH}/SetEnvironmentVariables.sh

touch /etc/systemd/system/nodemanager.service
chmod u+x /etc/systemd/system/nodemanager.service

echo '[Unit]
Description=Node Manager controls the WebLogic Server runtime lifecycle
After=network.target
[Service]
User='${ORACLE_INSTALL_USER}'
Group='${ORACLE_INSTALL_GROUP}'
Type=simple
ExecStart='${DOMAIN_CONFIGURATION_HOME}'/bin/startNodeManager.sh >/dev/null 2>/dev/null &
ExecStop='${DOMAIN_CONFIGURATION_HOME}'/bin/stopNodeManager.sh >/dev/null 2>/dev/null &
PIDFile='${NODE_MANAGER_HOME}'/nodemanager.process.id
Restart=on-failure
RestartSec=1
[Install]
WantedBy=default.target' > /etc/systemd/system/nodemanager.service

systemctl daemon-reload
systemctl enable nodemanager.services
