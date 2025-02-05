https://ipcorenetworks.blogspot.com/2021/08/installing-nfsen-nfdump-on-ubuntu-and.html
https://ws.learn.ac.lk/wiki/NspwUprouse/Agenda/netflow
https://ipcorenetworks.blogspot.com/2022/02/installing-nfsen-nfdump-porttracker.html
https://ipcorenetworks.blogspot.com/2021/09/how-to-install-configure-loganalyzer.html
-- https://www.youtube.com/watch?v=wlLvJcFqHYw

https://nsrc.org/workshops/2017/sanog29-cndo/networking/cndo/en/labs/9.31_setting_up_nfsen.html


### APNIC TUTORIAL ###

sudo apt-get update && sudo apt-get -y dist-upgrade
sudo add-apt-repository ppa:ondrej/php

sudo apt install -y make nano git gcc flex rrdtool librrd-dev libpcap-dev php librrds-perl libsocket6-perl apache2 \
libapache2-mod-php8.1 libtool dh-autoreconf pkg-config libbz2-dev byacc doxygen graphviz cpanminus unzip tree


cd ~
git clone https://github.com/phaag/nfdump.git
cd nfdump

sudo ./autogen.sh
sudo ./configure --enable-nsel --enable-nfprofile --enable-sflow --enable-readpcap --enable-nfpcapd
sudo make all
sudo make install
sudo ldconfig
nfdump -V

cd ~
wget https://github.com/p-alik/nfsen/archive/nfsen-1.3.8.zip
unzip nfsen-1.3.8.zip && cd nfsen-nfsen-1.3.8



sudo cpan App::cpanminus
sudo cpanm Mail::Header
sudo cpanm Mail::Internet


less ./etc/nfsen-dist.conf

grep -in "www\"" ./etc/nfsen-dist.conf
sed -i 's/www\"/www\-data\"/' ./etc/nfsen-dist.conf
grep -in "www\-" ./etc/nfsen-dist.conf


grep -in "sources =" -A 4 ./etc/nfsen-dist.conf
grep -in "peer" ./etc/nfsen-dist.conf
sed -i '/peer/d' ./etc/nfsen-dist.conf

grep -in "upstream1" ./etc/nfsen-dist.conf
sed -i 's/upstream1/group30router/' ./etc/nfsen-dist.conf
grep -in "sources =" -A 4 ./etc/nfsen-dist.conf

grep -in "www\/" ./etc/nfsen-dist.conf
sed -i 's/www\//www\/html\//' ./etc/nfsen-dist.conf
grep -in "www\/" ./etc/nfsen-dist.conf


grep -in 2000  ./etc/nfsen-dist.conf
sed -i 's/2000/20/' ./etc/nfsen-dist.conf
grep -in 2000  ./etc/nfsen-dist.conf



sudo mkdir -p /data/nfsen
sudo useradd -d /data/nfsen -M -s /bin/false -G www-data netflow




rrdtool -V
grep -in "1.6" ./libexec/NfSenRRD.pm
sed -i 's/1.6/1.8/' ./libexec/NfSenRRD.pm
grep -in "< 1.8" ./libexec/NfSenRRD.pm




sudo ./install.pl ./etc/nfsen-dist.conf




sudo ln -s /data/nfsen/bin/nfsen /etc/init.d/nfsen
sudo update-rc.d nfsen defaults 20


sudo systemctl start nfsen
sudo systemctl status nfsen



sudo /usr/local/bin/nfcapd -D -p 9995 -u netflow -g www-data -B 2000 -S 1 -z -I group30router -w /data/nfsen/profiles-data/live/group30router



http://group30-server.apnictraining.net/nfsen/nfsen.php














