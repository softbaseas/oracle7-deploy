#!/bin/bash
cd /home/tomcat/ordstomcat/
#read -p "Enter name for database Server: " db_server
#read -p "Enter port for database server (1521): " db_port
#read -p "Enter name database dame: " db_name
#echo -n "Enter password for ORDS_PUBLIC_USER:  "
#read -s ords_pwd
#echo -n "Enter password for mm1: "
#read -s mm1_pwd

#if [ -z ${db_port} ]; then
#    db_port="1521"
#fi

#echo;

#echo "Database Server           = $db_server"
#echo "Database Port             = $db_port"
#echo "Database Name             = $db_name"
#echo "ORDS_PUBLIC_USER Password = $ords_pwd"
#echo "mm1 Password              = $mm1_pwd"

while true; do
    read -p "Has ORDS already been configured [Y/n]? " yn
    case $yn in
        [Nn]* ) echo "ORDS needs to be configured before deploying to Tomcat. Configuration has to be done manually."; exit; break;;
        * ) echo "Deploying ORDS to Tomcat...";break;;
    esac
done

mv tomcatconfig/ords/defaults.xml tomcatconfig/ords/defaults.xml.org
sed '/<\/properties>/{
	r template_files/force-ssl.xml
	a \</properties>
	d
}' tomcatconf/ords/defaults.xml >> tomcatconf/ords/defaults.xml

chown -R tomcat:tomcat /home/tomcat
ln -s /home/ordstomcat/ords.war /usr/share/tomcat/webapps/

echo "ORDS deployed."

while true; do
    read -p "Configure Apex Rest [Y/n]? " yn
    case $yn in
        [Nn]* ) exit; break;;
        * ) ./includes/oracle/restful.sh $db_pwd;break;;
    esac
done
