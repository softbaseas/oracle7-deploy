#!/bin/bash
#echo -n "Enter new FQDN (ex: my-domain.tld): "
#read new_fqdn
#echo "Domain: $new_fqdn"

fqdn=$1;

# If test virtual host exists
if [ -f /etc/httpd/sites-enabled/001-sbsv12master.softbase.dk.conf ]; then
    while true; do
        read -p "Do you wish to remove the test virtual host? [Y/n]? " yn
        case $yn in
            [Nn]* ) break;;
            * ) rm /etc/httpd/sites-enabled/001-sbsv12master.softbase.dk.conf;break;;
        esac
    done
fi

if [ -f /etc/httpd/sites-available/002-$fqdn.conf ]; then
    echo "File 002-$fqdn.conf already exist."
    echo "File not created."
else
    echo "File 002-$fqdn.conf does not exist."
    sed "s/domain.tld/$fqdn/" ./template_files/awo_httpd_ssl-template.conf > /etc/httpd/sites-available/002-$fqdn.conf
    echo "File created."
fi

# Enable ords proxy
ln -s /etc/httpd/sites-available/002-$fqdn.conf /etc/httpd/sites-enabled/;
# Enable reports
ln -s /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/components/ReportsServerComponent/reports_ohs.conf /etc/httpd/sites-enabled/;
# Enable Forms
ln -s /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/components/FORMS/instances/forms1/server/forms.conf /etc/httpd/sites-enabled/;

# Restart apache and tomcat
service httpd restart;
service tomcat restart;
echo "Restarted httpd and Tomcat.";

# Enable apache and tomcat
systemctl enable httpd;
systemctl enable tomcat;
echo "Enabled auto start for httpd and Tomcat.";

echo "Virtual hosts added to httpd."

# To fix the SELinux Shit:
#chcon -R -h -t httpd_sys_script_exec_t /var/html/error.log    # Should be added in the master template
#chcon -R -h -t httpd_sys_script_exec_t /var/html/requests.log # Should be added in the master template
#chcon -R -h -t httpd_sys_script_exec_t /etc/httpd/sites-available/002-$1.conf
#chcon -R -h -t httpd_sys_script_exec_t /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/components/ReportsServerComponent/reports_ohs.conf
#chcon -R -h -t httpd_sys_script_exec_t /home/oracle/Oracle/Middleware12c/ofr1/user_projects/domains/SBErpc12/config/fmwconfig/components/FORMS/instances/forms1/server/forms.conf

# Adding read/write access to /var/www/html and /var/www/html/public
#chcon -R -h -t httpd_sys_rw_content_t /var/www/html/public
#chcon -R -h -t httpd_sys_rw_content_t /var/www/html
