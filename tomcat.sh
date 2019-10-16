# tomcat-install-in-ubuntu
How to Install Apache Tomcat in Ubuntu
================================
https://www.tecmint.com/install-apache-tomcat-in-ubuntu/

sudo apt-get update
sudo apt-get install default-jdk
sudo apt-get install unzip
cd /opt
wget http://apachemirror.wuchna.com/tomcat/tomcat-9/v9.0.27/bin/apache-tomcat-9.0.27.tar.gz
tar xzf apache-tomcat-9.0.27.tar.zip
tar -xvzf apache-tomcat-9.0.27.tar.zip
sudo mv apache-tomcat-8.5.15 tomcat

sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

sudo chgrp -R tomcat /opt/tomcat
sudo chown -R tomcat /opt/tomcat
sudo chmod -R 755 /opt/tomcat

sudo /etc/systemd/system/tomcat.service

[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target


sudo ufw allow 8080
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat

http://ip-address:8080

$ systemctl enable tomcat

Step 5: Configuring Apache Tomcat


sudo vim /opt/tomcat/conf/tomcat-users.xml

<role rolename="manager-gui"/>
<role rolename="admin-gui"/>
<user username="Username" password="Password" roles="manager-gui,admin-gui"/>

sudo vim /opt/tomcat/webapps/manager/META-INF/context.xml

<Context antiResourceLocking="false" privileged="true" >
chanaged to <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>



sudo vim /opt/tomcat/webapps/host-manager/META-INF/context.xml


<Context antiResourceLocking="false" privileged="true" >
chanaged to <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>

sudo systemctl restart tomcat 
