#!/bin/bash
echo "30 5 * * * /opt/certbot/certbot-auto -n renew --pre-hook \"service httpd stop\" --post-hook \"service httpd start\" >> /root/certbot-log/renew.log" >> /etc/crontab
echo "Cronjob added.s"
