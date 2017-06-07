#!/bin/bash
fqdn=$1;
service httpd stop
/opt/certbot/certbot-auto certonly --standalone --email support@softbase.dk --agree-tos -d $fqdn
service httpd start
