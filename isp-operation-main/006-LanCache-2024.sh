root@lancache1:~# cat /opt/lc-install.sh
    1  cd
    2  apt update
    3  apt install tmux
    4  tmux
    5  apt dist-upgrade -y
    6  apt upgrade
    7  apt upgrade -y
    8  htop
    9  ll
   10  ifcon
   11  ip -br a
   12  vim /etc/ssh/sshd_config
   13  systemctl restart ssh
   14  systemctl restart sshd
   15  systemctl status ssh
   16  systemctl status sshd
   17  passwd root
   18  df -h
   19  apt update
   20  ip -br a
   21  mtr
   22  mtr 9.9.9.9
   23  mtr 8.8.8.8
   24  nslookup yahoo.com
   25  apt update
   26  apt upgrade -y
   27  dpkg-reconfigure tzdata
   28  apt install -y ifupdown vim net-tools
   29  vim /etc/netplan/01-netcfg.yaml
   30  reboot
   31  apt update
   32  apt upgrade
   33  apt install -y ifupdown vim net-tools
   34  vim /etc/default/grub
   35  update-grub
   36  apt install --install-recommends linux-generic-hwe-20.04
   37  update-grub
   38  apt install --install-recommends linux-generic-hwe-20.04
   39  vim /etc/apt/sources.list
   40  apt update
   41  apt upgrade -y
   42  apt autoremove
   43  sudo systemctl stop systemd-resolved
   44  sudo systemctl disable systemd-resolved.service
   45  rm -fr /etc/resolv.conf
   46  touch /etc/resolv.conf
   47  echo "nameserver 8.8.8.8" >> /etc/resolv.conf
   48  echo "nameserver 1.0.0.3" >> /etc/resolv.conf
   49  vim /etc/security/limits.conf
   50  vim /etc/sysctl.conf
   51  dpkg-reconfigure dash  ---> No
   52  dpkg-reconfigure dash
   53  apt install wget curl vim sudo rsyslog -y
   54  apt -y install locales locales-all
   55  localectl set-locale LANG=en_US.UTF-8 LANGUAGE="en_US:en"
   56  export LANG=en_US.UTF-8
   57  cd /root/
   58  echo "export LANG=en_US.UTF-8" >> .profile
   59  echo "export LANG=en_US.UTF-8" >> .bashrc
   60  reboot
   61  rm -fr /etc/update-motd.d/*
   62  htop
   63  swapon
   64  sudo swapoff /swapfile
   65  sudo fallocate -l 16G /swapfile
   66  sudo fallocate -l 24G /swapfile
   67  sudo fallocate -l 16G /swapfile
   68  sudo mkswap /swapfile
   69  sudo swapon /swapfile
   70  vim /etc/default/grub
   71  update-grub
   72  reboot
   73  df -h
   74  htop
   75  ifconfig
   76  ip -br a
   77  sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
   78  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   79  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   80  apt update
   81  apt-cache policy docker-ce
   82  sudo apt install docker-ce -y
   83  sudo systemctl status docker
   84  sudo apt update
   85  docker --version
   86  sudo apt install ca-certificates curl
   87  sudo install -m 0755 -d /etc/apt/keyrings
   88  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   89  sudo chmod a+r /etc/apt/keyrings/docker.asc
   90  echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   91  sudo apt update
   92  sudo apt install docker-compose-plugin -y
   93  apt search docker-compose
   94  apt install docker-compose-v2
   95  apt install docker-compose
   96  cd /etc/apt/sources.list.d/
   97  ls
   98  vim docker.list
   99  cd ..
  100  vim sources.list
  101  apt update
  102  apt upgrade -y
  103  cd
  104  dpkg -l |grep  docker-compose
  105  mkdir /opt/lc
  106  cd /opt/lxc
  107  cd /opt/lc
  108  git clone https://github.com/lancachenet/docker-compose/ lancache
  109  ll
  110  cd lancache/
  111  ls
  112  vim .env
  113  vim docker-compose.yml
  114  docker-compose up -d
  115  dpkg -l |grep docker
  116  sudo apt -y install docker-ce docker-ce-cli containerd.io
  117  docker version
  118  docker run docker/whalesay cowsay Hello-World!
  119  apt install locate
  120  updatedb
  121  locate docker-compose |grep bin
  122  docker-compose -v
  123  cp -r /usr/bin/docker-compose /usr/local/bin/
  124  chmod +x /usr/bin/docker-compose
  125  chmod +x /usr/local/bin/docker-compose
  126  docker-compose --version
  127  docker-proxy --version
  128  docker-compose -up -d
  129  docker-compose up -d
  130  docker compose up -d
  131  docker ps
  132  ls -lah
  133  vim /etc/resolv.conf
  134  nslookup google.com
  135  df -h
  136  vim docker-compose.yml
  137  mc
  138  apt install mc
  139  mc
  140  ls
  141  docker exec -it lancache_dns_1 bash
  142  docker ps
  143  docker exec -it lancache-dns-1 bash
  144  sudo nslookup steam.cache.lancache.net
  145  rndc status
  146  apt install bind9-utils
  147  rndc status
  148  docker exec -it lancache-dns-1 bash
  149  sudo nslookup steam.cache.lancache.net
  150  cd
  151  history > /opt/lc-install.sh



########### ENV FILE ###########

vim .env

## See the "Settings" section in README.md for more details
USE_GENERIC_CACHE=true
LANCACHE_IP=192.168.105.27
DNS_BIND_IP=192.168.105.27
UPSTREAM_DNS=172.16.166.2
CACHE_ROOT=./lcdata
CACHE_DISK_SIZE=250g
CACHE_INDEX_SIZE=500m
CACHE_MAX_AGE=60d
TZ=Asia/Dhaka


vim docker-compose.yml

version: '2'
services:
  dns:
    image: lancachenet/lancache-dns:latest
    env_file: .env
    restart: always
    ports:
      - ${DNS_BIND_IP}:53:53/udp
      - ${DNS_BIND_IP}:53:53/tcp

  monolithic:
    image: lancachenet/monolithic:latest
    env_file: .env
    restart: always
    ports:
      - 80:80/tcp
      - 443:443/tcp
    volumes:
      - ${CACHE_ROOT}/cache:/data/cache
      - ${CACHE_ROOT}/logs:/data/logs



docker exec -it lancache-dns-1 bash
vim /etc/bind/named.conf.options


#
options {
        directory "/var/cache/bind";
        dnssec-validation no;
        auth-nxdomain no;    # conform to RFC1035
        allow-recursion { any; };
        allow-query { any; };
        allow-query-cache { any; };
        listen-on { any; };
        listen-on-v6 { any; };
        max-cache-ttl 0;
        max-ncache-ttl 0;
        forward only;

        recursive-clients 3000;
        tcp-clients 300;
        # Permit RFC1918 PTR lookups to be recursed upstream
        empty-zones-enable no;
        response-policy { zone "rpz"; };
        rrset-order { order cyclic; };
        forwarders { 172.16.166.2; };
};




# https://cylab.be/blog/209/network-monitoring-log-dns-queries-with-bind

/etc/bind/named.conf.options:


logging {
        channel default_log {
                file "/var/log/bind/default.log";
                print-time yes;
                print-category yes;
                print-severity yes;
                severity info;
        };

        category default { default_log; };
        category queries { default_log; };
};


sudo service bind9 restart

https://nsrc.org/activities/agendas/en/dnssec-3-days/dns/materials/labs/en/dns-bind-logging.html

  
