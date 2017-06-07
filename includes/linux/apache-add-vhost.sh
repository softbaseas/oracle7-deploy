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

# Enable page?
while true; do
    read -p "Do you wish to enable the virtual host now [Y/n]? " yn
    case $yn in
        [Nn]* ) echo "No: Add symlink to /etc/httpd/sites-enabled/ when needed."; break;;
        * ) ln -s /etc/httpd/sites-available/002-$fqdn.conf /etc/httpd/sites-enabled/;break;;
    esac
done

# Enable Reports?
while true; do
    read -p "Do you wish to enable the Reports OHS now [Y/n]? " yn
    case $yn in
        [Nn]* ) echo "No: Add symlink to /etc/httpd/sites-enabled/ when needed."; break;;
        * ) ln -s /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/components/ReportsServerComponent/reports_ohs.conf /etc/httpd/sites-enabled/;break;;
    esac
done

# Enable Forms?
while true; do
    read -p "Do you wish to enable the Forms now [Y/n]? " yn
    case $yn in
        [Nn]* ) echo "No: Add symlink to /etc/httpd/sites-enabled/ when needed."; break;;
        * ) ln -s /home/oracle/Oracle/Middleware12c/ofr_1/user_projects/domains/SBErp12c/config/fmwconfig/components/FORMS/instances/forms1/server/forms.conf /etc/httpd/sites-enabled/;break;;
    esac
done

while true; do
    read -p "Restart Apache and Tomcat [Y/n]? " yn
    case $yn in
        [Nn]* ) echo "Do systemctl restart httpd && systemctl restart tomcat when needed."; break;;
        * ) service httpd restart; service tomcat restart; echo "Restarted HTTPD and Tomcat."break;;
    esac
done

while true; do
    read -p "Enable Apache and Tomcat on reboot [Y/n]? " yn
    case $yn in
        [Nn]* ) break;;
        * ) update-rc.d httpd defaults; update-rc.d tomcat defaults; echo "Enabled auto start for HTTPD and Tomcat."break;;
    esac
done

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
