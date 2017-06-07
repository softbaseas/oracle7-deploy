#!/bin/bash
cd /home/tomcat/ordstomcat/
read -p "Enter name for Database Server: " db_server
read -p "Enter port for Database Server (1521): " db_port
read -p "Enter name Database Name: " db_name
echo -n "Enter Database Password: "
read -s db_pwd

if [ -z ${db_port} ]; then
    db_port="1521"
fi

echo;

echo "Database Server   = $db_server"
echo "Database Port     = $db_port"
echo "Database Name     = $db_name"
echo "Database Password = $db_pwd"

while true; do
    read -p "Is the information above correct [Y/n]? " yn
    case $yn in
        [Nn]* ) exit; break;;
        * ) echo "Continueing...";break;;
    esac
done

java -jar ords.war << END
tomcatconfig
$db_server
$db_port
1
$db_name
ORDS_PUBLIC_USER
$db_pwd
$db_pwd
1
$db_pwd
$db_pwd
1
$db_pwd
$db_pwd
$db_pwd
$db_pwd
2
END

echo "ORDS Install complete."

while true; do
    read -p "Configure RESTful [Y/n]? " yn
    case $yn in
        [Nn]* ) exit; break;;
        * ) ./includes/oracle/configure_restful.sh $db_pwd;break;;
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

echo "ORDS installed in tomcat."
