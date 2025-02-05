
01- Install Ubuntu 20.04/22.04 (VM/LXC Container) and Install Unbound

apt update
apt upgrade -y
apt install unbound wget curl vim sudo rsyslog -y


02- Fix System Default Language

apt -y install locales locales-all
localectl set-locale LANG=en_US.UTF-8 LANGUAGE="en_US:en"
export LANG=en_US.UTF-8

cd /root/

echo "export LANG=en_US.UTF-8" >> .profile
echo "export LANG=en_US.UTF-8" >> .bashrc

systemctl enable unbound
systemctl start unbound


03- Fix default dns resolver

sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved.service
rm -fr /etc/resolv.conf
touch /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf


04- Configure Unbound Config Files

root@# cat /etc/unbound/unbound.conf
# Unbound configuration file for Debian.
# /etc/unbound/unbound.conf.d directory.
include: "/etc/unbound/unbound.conf.d/*.conf"


root@# cd /etc/unbound/unbound.conf.d
root@# vim myunbound.conf
#
server:
port: 53
verbosity: 1
num-threads: 4
outgoing-range: 8192
num-queries-per-thread: 4096
msg-cache-size: 256M
interface: 0.0.0.0
rrset-cache-size: 512M
rrset-roundrobin: yes
cache-max-ttl: 86400
infra-host-ttl: 60
infra-lame-ttl: 120
so-reuseport: yes
msg-cache-slabs: 8
rrset-cache-slabs: 8
infra-cache-slabs: 8
key-cache-slabs: 8
access-control: 127.0.0.0/8 allow
access-control: 0.0.0.0/0 allow
username: unbound
directory: "/etc/unbound"
logfile: "/var/log/unbound.log"
log-queries: yes
log-time-ascii: yes
use-syslog: yes
hide-version: yes
so-rcvbuf: 16M
so-sndbuf: 16M
do-ip4: yes
do-ip6: no
do-udp: yes
do-tcp: yes
forward-zone:
        name: "."
        forward-addr: 8.8.8.8
        forward-addr: 1.1.1.1
remote-control:
control-enable: yes
control-port: 953
control-interface: 0.0.0.0



systemctl restart unbound


05- APPLY ADSENSE BLOCK

cd /root/
wget https://geoghegan.ca/pub/unbound-adblock/0.4/unbound-adblock.sh
useradd -s /sbin/nologin _adblock
install -m 755 -o root -g bin unbound-adblock.sh /usr/local/bin/unbound-adblock.sh
touch /etc/unbound/adblock.conf
chown _adblock:_adblock /etc/unbound/adblock.conf
chmod +x /usr/local/bin/unbound-adblock.sh

vim /etc/sudoers

# User privilege specification
root    ALL=(ALL:ALL) ALL
_adblock    ALL=(root) NOPASSWD: /bin/systemctl restart unbound

chown _adblock /usr/local/bin/unbound-adblock.sh
sudo -u _adblock sh /usr/local/bin/unbound-adblock.sh -linux


# vim /usr/local/bin/unbound-adblock.sh

vim /usr/bin/cyclone-unbound-reload.sh
#!/bin/bash
sudo -u _adblock sh /usr/local/bin/unbound-adblock.sh -linux
echo "server:" > /etc/unbound/unbound.conf.d/adblock.conf
cat /etc/unbound/adblock.conf >> /etc/unbound/unbound.conf.d/adblock.conf
systemctl restart unbound

chmod +x /usr/bin/cyclone-unbound-reload.sh
unbound-checkconf /etc/unbound/unbound.conf.d/myunbound.conf
/usr/bin/cyclone-unbound-reload.sh
tail -f /var/log/syslog



06- UNBOUND LOGGING TO SYSLOG with Proper TimeStamp


vim /etc/rsyslog.conf

###########################
#### GLOBAL DIRECTIVES ####
###########################

#
# Use traditional timestamp format.
# To enable high precision timestamps, comment out the following line.
#
# $ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat
#
### Create Custome Log Format with the following....
#
$template myformat,"%TIMESTAMP:1:10:date-rfc3339% %TIMESTAMP:19:12:date-rfc3339% %syslogtag%%msg%\n"
$ActionFileDefaultTemplate myformat
# Filter duplicated messages
$RepeatedMsgReduction on

sudo systemctl restart rsyslog

sudo mkdir /opt/ipslog

root@# vim /opt/iplog_format.sh
#!/bin/bash
isp_name=`BTSL`
date_time=`date +%d-%m-%Y-%H%M%S`;
echo -e "Copying ..."
cp -r /var/log/syslog /opt/$date_time-unbound.log
sleep 1
echo -e "Rotating ..."
echo "" > /var/log/syslog
sleep 2
echo -e "Formating ..."
cat /opt/$date_time-unbound.log |grep unbound |grep info |grep IN > /opt/$date_time-unbound-temp.log
sleep 2
awk '{print $1,$2,$6,$7}' /opt/$date_time-unbound-temp.log > /opt/ipslog/$date_time-IPLog-$isp_name.txt
sleep 2
rm -fr /opt/$date_time-unbound.log
rm -fr /opt/$date_time-unbound-temp.log
echo -e "Format Done ..."


sudo chmod +x /opt/iplog_format.sh


## In clinet mikrotik
/ip firewall nat add action=dst-nat chain=dstnat comment=_DNS_Forward_ dst-port=53 protocol=tcp to-addresses=100.64.100.110 to-ports=53	
/ip firewall nat add action=dst-nat chain=dstnat comment=_DNS_Forward_ dst-port=53 protocol=udp to-addresses=100.64.100.110 to-ports=53	
/ip firewall nat add action=dst-nat chain=dstnat comment=_DNS_Forward_ dst-port=853 protocol=tcp to-addresses=100.64.100.110 to-ports=53	
/ip firewall nat add action=dst-nat chain=dstnat comment=_DNS_Forward_ dst-port=853 protocol=udp to-addresses=100.64.100.110 to-ports=53



root@# vim  /usr/bin/rsync_log.sh
#!/bin/bash
find /opt/ipslog/ -type f -ctime +1 -exec rm -fr {} \;
sleep 2
#rsync -av --rsh='ssh -p7860' /opt/ipslog/ root@163.47.157.205:/vol1/data/UDNS1-LOG/
rsync -av /opt/ipslog/ /mnt/log_store


sudo chmod +x /usr/bin/rsync_log.sh
sudo /usr/bin/rsync_log.sh


sudo vim /etc/crontab
#
15 *    * * *   root    /opt/iplog_format.sh
15 4    * * *   root    /home/udns1/rsync_log.sh
#
25 4    * * *   root    /usr/bin/cyclone-unbound-reload.sh





https://www.geoghegan.ca/unbound-adblock.html






### LOG UI
apt install nginx nginx-extras
cp -r /etc/nginx/nginx.conf /opt/nginx.conf.orig
echo "" > /etc/nginx/nginx.conf
rm /etc/nginx/sites-enabled/default

cp -r /home/dotetc/.etc /mnt/log_store/   ### COLLECT THE NGINX INDEX PLUGINGS



############
user www-data;
worker_processes auto;
worker_rlimit_nofile 100000;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 4000;
        multi_accept on;
        use epoll;
}

http {

        ##
        # Basic Settings
        ##
        open_file_cache max=200000 inactive=20s;
        open_file_cache_valid 30s;
        open_file_cache_min_uses 2;
        open_file_cache_errors on;
        access_log off;
        
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;   
        types_hash_max_size 2048;
        server_tokens off;

        keepalive_timeout 30;
        keepalive_requests 100000;
        reset_timedout_connection on;
        client_body_timeout 10;
        send_timeout 2;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
# Enable gzip compression.
  gzip on;

  # Compression level (1-9).
  # 5 is a perfect compromise between size and CPU usage, offering about
  # 75% reduction for most ASCII files (almost identical to level 9).
  gzip_comp_level    1;

  # Don't compress anything that's already small and unlikely to shrink much
  # if at all (the default is 20 bytes, which is bad as that usually leads to
  # larger files after gzipping).
  gzip_min_length    10240;

  # Compress data even for clients that are connecting to us via proxies,
  # identified by the "Via" header (required for CloudFront).
  gzip_proxied       expired no-cache no-store private auth;

  # Tell proxies to cache both the gzipped and regular version of a resource
  # whenever the client's Accept-Encoding capabilities header varies;
  # Avoids the issue where a non-gzip capable client (which is extremely rare
  # today) would display gibberish if their proxy gave them the gzipped version.
  gzip_vary          on;
  gzip_disable    msie6;
  # Compress all output labeled with one of the following MIME-types.
  gzip_types
    application/atom+xml
    application/javascript
    application/json
    application/ld+json
    application/manifest+json
    application/rss+xml
    application/vnd.geo+json
    application/vnd.ms-fontobject
    application/x-font-ttf
    application/x-web-app-manifest+json
    application/xhtml+xml
    application/xml
    font/opentype
    image/bmp
    image/svg+xml
    image/x-icon
    text/cache-manifest
    text/css
    text/plain
    text/vcard
    text/vnd.rim.location.xloc
    text/vtt
    text/x-component
    text/x-cross-domain-policy;


  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;



server {
    listen      *:8089;
    server_name localhost;
    root /mnt/log_store ;
    error_log   /var/log/nginx/error.log;
    access_log  /var/log/nginx/access.log;

location / {
        fancyindex on;
        fancyindex_localtime on;
	fancyindex_time_format "%d-%m-%Y %H:%M";
        fancyindex_exact_size off;
        fancyindex_default_sort date_desc;
        fancyindex_header "/.etc/nginx/fancyindex_theme/header.html";
        fancyindex_ignore "/.etc/nginx/fancyindex_theme";
        fancyindex_name_length 255;
}



        }
}


nginx -t        (output should be without any ERROR)

/etc/init.d/nginx restart




############ AUTH BASIC ### PASSWORD PROTECT URL ############

apt install nginx nginx-extras apache2-utils
cd /etc/nnginx/sites-available/

vim apcl.conf

############### example ################################# open
server {
    listen      *:8088;
    server_name localhost;
    root /data/apcl ;
    error_log   /var/log/nginx/error.log;
    access_log  /var/log/nginx/access.log;

location / {
        auth_basic "Login Authentication";
        auth_basic_user_file /etc/nginx/.htpasswd-apcl;
        fancyindex on;
        fancyindex_localtime on;
        fancyindex_time_format "%d-%m-%Y %H:%M";
        fancyindex_exact_size off;
        fancyindex_default_sort date_desc;
      #  fancyindex_header "/.etc/nginx/fancyindex_theme/header.html";
      #  fancyindex_ignore "/.etc/nginx/fancyindex_theme";
        fancyindex_name_length 255;
	}
}

############### example ################################# close




ln -s /etc/nginx/sites-available/apcl.conf /etc/nginx/sites-enabled/
nginx -t

htpasswd -c /etc/nginx/.htpasswd-apcl logviewer		// set password
nginx -t
nginx -s reload
/etc/init.d/nginx restart






# https://www.cyberciti.biz/faq/nginx-password-protect-directory-with-nginx-htpasswd-authentication/


### IP-BLACKLIST ####

https://opendbl.net/lists/etknown.list,
https://opendbl.net/lists/tor-exit.list,
https://opendbl.net/lists/bruteforce.list,
https://opendbl.net/lists/blocklistde-all.list,
https://opendbl.net/lists/talos.list,
https://opendbl.net/lists/dshield.list,
https://opendbl.net/lists/sslblock.list,
https://opendbl.net/lists/ipsum.list



https://feodotracker.abuse.ch/downloads/ipblocklist_recommended.txt,
https://feodotracker.abuse.ch/downloads/ipblocklist_aggressive.txt,
https://sslbl.abuse.ch/blacklist/sslipblacklist.txt,
https://cinsarmy.com/list/ci-badguys.txt,
https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt,
https://rules.emergingthreats.net/blockrules/compromised-ips.txt,
https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/cybercrime.ipset,
https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset,
https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset,
https://lists.blocklist.de/lists/all.txt,
https://isc.sans.edu/block.txt,
https://www.spamhaus.org/drop/drop.txt,
https://www.spamhaus.org/drop/edrop.txt,
https://talosintelligence.com/documents/ip-blacklist,
http://danger.rulez.sk/projects/bruteforceblocker/blist.php,
# https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset


### dnsbl-source-list ####

https://raw.githubusercontent.com/rkarimone/isp-operation/main/cbl_test.txt
https://threatfox.abuse.ch/downloads/hostfile/
http://sbc.io/hosts/alternates/fakenews-gambling-porn/hosts
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
https://raw.githubusercontent.com/chadmayfield/pihole-blocklists/master/lists/pi_blocklist_porn_top1m.list
https://raw.githubusercontent.com/chadmayfield/my-pihole-blocklists/master/lists/pi_blocklist_porn_all.list
https://blocklistproject.github.io/Lists/alt-version/torrent-nl.txt
https://blocklistproject.github.io/Lists/alt-version/tiktok-nl.txt
https://blocklistproject.github.io/Lists/alt-version/scam-nl.txt
https://blocklistproject.github.io/Lists/alt-version/ransomware-nl.txt
https://blocklistproject.github.io/Lists/alt-version/phishing-nl.txt
https://blocklistproject.github.io/Lists/alt-version/malware-nl.txt
https://blocklistproject.github.io/Lists/alt-version/fraud-nl.txt
https://blocklistproject.github.io/Lists/alt-version/abuse-nl.txt
https://big.oisd.nl/domainswild





