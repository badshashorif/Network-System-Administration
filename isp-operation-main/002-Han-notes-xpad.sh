   118	21:21	pkg fetch -d -o /opt/bwm-ng/ bsnmp-ucd
   119	21:21	ls bwm-ng/
   120	21:21	ls bwm-ng/All/
   121	21:21	mkdir pkgs
   122	21:21	pkg fetch -d -o /opt/pkgs/ bsnmp-ucd
   123	21:22	pkg fetch -d -o /opt/pkgs/ iftop htop
   124	21:22	ll
   125	21:22	ll pkgs/All/
   126	21:23	pkg fetch -d -o /opt/pkgs/ iperf3
   127	21:23	pkg fetch -d -o /opt/pkgs/ rsync
   128	21:23	pkg fetch -d -o /opt/pkgs/ mtr
   129	21:25	ll pkgs/All/
   130	21:25	scp -P 8443 -r /opt/pkgs/ root@172.25.50.1:/home/noc/


pkg add /opt/pkgs/All/*


########################


https://www.digitalocean.com/community/questions/ubuntu-22-04-apache-php-fpm
https://www.digitalocean.com/community/tutorials/how-to-configure-apache-http-with-mpm-event-and-php-fpm-on-ubuntu-18-04
https://tecadmin.net/how-to-install-apache-with-php-fpm-on-ubuntu-22-04/
https://tecadmin.net/search/mpm/

https://tecadmin.net/comparing-worker-and-prefork-apache-mpm/




sudo apt update && sudo apt upgrade -y
sudo apt update && sudo apt install apache2 -y
apt install iftop htop mtr mc traceroute bwm-ng glances nano openssh-server -y
apt install net-tools ifupdown -y
vim /etc/ssh/sshd_config

netstat -tulpn																>>>> [Checking port]


sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved.service
rm -fr /etc/resolv.conf
touch /etc/resolv.conf
echo "nameserver 1.0.0.3" > /etc/resolv.conf
netstat -tulpn
 

apt search mysql
apt search mysql-server
apt install mysql-server -y
mysql
mysqladmin version															>>>>> [Server version          8.0.27-0ubuntu0.20.04.1]

apt install nginx -y
apt install nginx nginx-extras -y
vim /etc/nginx/nginx.conf
vim /etc/nginx/sites-enabled/default

cd /var/www/html/
cp index.nginx-debian.html index.html


apt install apache2 -y
vim /etc/apache2/ports.conf 
vim /etc/apache2/apache2.conf 
/etc/init.d/apache2 restart







After that,

vim /etc/nginx/sites-enabled/default

	vi /etc/nginx/sites-enabled/default
   
   
# Default server configuration

server {
        listen 8880 default_server;
        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;


        location / {
                try_files $uri $uri/ /index.php?$args;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }

}


vim /etc/apache2/sites-enabled/000-default.conf

<VirtualHost *:80>
     ServerAdmin admin@hostmaster
     ServerName localhost
     DocumentRoot /var/www/html
     DirectoryIndex index.php index.html info.php

     <Directory /var/www/html>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
     </Directory>

    <FilesMatch \.php$>
         SetHandler "proxy:unix:/run/php/php5.6-fpm.sock|fcgi://localhost"
    </FilesMatch>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined

#     ErrorLog ${APACHE_LOG_DIR}/site1.your_domain_error.log
#     CustomLog ${APACHE_LOG_DIR}/site1.your_domain_access.log combined
</VirtualHost>





systemctl disable postfix
systemctl stop postfix
netstat -tulpn

sudo apt install python-software-properties
add-apt-repository ppa:ondrej/php
apt install software-properties-common

sudo apt install php8.0 php8.0-fpm php8.0-mysql -y
sudo apt install php7.4 php7.4-fpm php7.4-mysql -y
sudo apt install php5.6 php5.6-fpm php5.6-mysql -y
sudo apt install php7.2 php7.2-fpm php7.2-mysql -y
sudo apt install php8.1 php8.1-fpm php8.1-mysql -y

apt-get -y install php8.0 php8.0-common php8.0-gd php8.0-mysql php8.0-imap php8.0-cli php8.0-cgi php-pear mcrypt imagemagick libruby php8.0-curl php8.0-intl php8.0-pspell php8.0-sqlite3 php8.0-tidy php8.0-xmlrpc php8.0-xsl memcached php8.0-memcache php8.0-imagick php8.0-gettext php8.0-zip php8.0-mbstring php8.0-soap php8.0-soap
apt-get -y install php8.1 php8.1-common php8.1-gd php8.1-mysql php8.1-imap php8.1-cli php8.1-cgi php-pear mcrypt imagemagick libruby php8.1-curl php8.1-intl php8.1-pspell php8.1-sqlite3 php8.1-tidy php8.1-xmlrpc php8.1-xsl memcached php8.1-memcache php8.1-imagick php8.1-gettext php8.1-zip php8.1-mbstring php8.1-soap php8.1-soap
apt-get -y install php7.4 php7.4-common php7.4-gd php7.4-mysql php7.4-imap php7.4-cli php7.4-cgi php-pear mcrypt imagemagick libruby php7.4-curl php7.4-intl php7.4-pspell php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl memcached php7.4-memcache php7.4-imagick php7.4-gettext php7.4-zip php7.4-mbstring php7.4-soap php7.4-soap
apt-get -y install php5.6 php5.6-common php5.6-gd php5.6-mysql php5.6-imap php5.6-cli php5.6-cgi php-pear mcrypt imagemagick libruby php5.6-curl php5.6-intl php5.6-pspell php5.6-sqlite3 php5.6-tidy php5.6-xmlrpc php5.6-xsl memcached php5.6-memcache php5.6-imagick php5.6-gettext php5.6-zip php5.6-mbstring php5.6-soap php5.6-soap
apt-get -y install php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-imap php7.2-cli php7.2-cgi php-pear mcrypt imagemagick libruby php7.2-curl php7.2-intl php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl memcached php7.2-memcache php7.2-imagick php7.2-gettext php7.2-zip php7.2-mbstring php7.2-soap php7.2-soap

dpkg -l |grep php |grep fpm
apt install mlocate
updatedb





<VirtualHost *:80>
    ServerName example.com
    ServerAlias www.example.com
    DocumentRoot /var/www/html
 
    <Directory /var/www/html>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>
 
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"
    </FilesMatch>
 
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>


# https://www.ma-no.org/en/networking/how-to-reset-ispconfig-3-admin-password

cat /usr/local/ispconfig/server/lib/mysql_clientdb.conf
$clientdb_host = ‘localhost’;
$clientdb_user = ‘root’;
$clientdb_password = ‘VerySecurePassword’;

mysql_clientdb.conf
mysql -h localhost -p dbispconfig

UPDATE sys_user SET passwort = md5('YourNewPassword') WHERE username = 'admin';
FLUSH PRIVILEGES;
quit;











