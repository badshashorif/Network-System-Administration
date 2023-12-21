#!/usr/bin/env bash

##########################################################################################################################

# Copyright 2022 Sysnote (sysnotecom@gmail.com)
# Author: Sysnote (sysnotecom@gmail.com)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>
#
# File : allions.sh : A simple shell script to Install Nagios Monitoring Tool.

##########################################################################################################################


# Text color variables

txtund=$(tput sgr 0 1)    # Underline
txtbld=$(tput bold)       # Bold
txtred=$(tput setaf 1)    # Red
txtgrn=$(tput setaf 2)    # Green
txtylw=$(tput setaf 3)    # Yellow
txtblu=$(tput setaf 4)    # Blue
txtpur=$(tput setaf 5)    # Purple
txtcyn=$(tput setaf 6)    # Cyan
txtwht=$(tput setaf 7)    # White
txtrst=$(tput sgr0)       # Text reset

clear

#########################################################################################################################
echo ""
echo ""
echo "#############################################################"
echo "#############################################################"
echo "##                                                         ##"
echo "##${txtgrn}         Welcome To All In One Nagios (AllION) Script${txtrst}    ##"
echo "##                  Created By sysnote                     ##"
echo "##          ${txtylw}       sysnotecom@gmail.com   ${txtrst}                 ##"
echo "##                                                         ##"
echo "#############################################################"
echo "#############################################################"
echo ""
echo ""
#########################################################################################################################

sleep 2


############ Variable Definitions  ################
path=`pwd`
log=/tmp/nagios_setup.log
nagios_core=`echo $latest_nagios`
folder_nagios=`echo $nagios_core | sed -e 's/.tar.gz//g'`
nagios_plugin=`echo $latest_plugin`
folder_plugin=`echo $nagios_plugin | sed -e 's/.tar.gz//g'`

############ Functions Definition ################

stop() {
sleep 2
echo ""
echo ""
exit 0
}

thankyou() {
#########################################################################################################################
echo ""
echo ""
echo "#############################################################"
echo "#############################################################"
echo "##                                                         ##"
echo "##${txtgrn}  Thank You for using All In One Nagios (AllION) Script${txtrst}  ##"
echo "##                  Created By sysnote                     ##"
echo "##          ${txtylw}       sysnotecom@gmail.com   ${txtrst}                 ##"
echo "##                                                         ##"
echo "#############################################################"
echo "#############################################################"
echo ""
echo ""
#############################################################################################################################
cd ..;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios_cfg.txt rpm_nagios.txt nagios_folder.txt targz.txt
sleep 2
}

finish() {
echo "${txtgrn}Congratulation, Nagios installation Completed successfullyy.${txtrst}"
sleep 5
echo "Nagios Installation Completed successfullyy" 2> /dev/null  >> $log
echo ""
echo "${txtpur}Here is detail information:${txtrst}"
sleep 2
echo "Here is the details:" 2> /dev/null  >> $log
echo "Nagios Web Frontend Url             : ${txtcyn}http://localhost/nagios${txtrst}  or  ${txtcyn}http://ip_address_server/nagios${txtrst}"
echo "Nagios Web Frontend Url ' http://localhost/nagios ' or ' http://ip_address_server/nagios '" 2> /dev/null  >> $log
echo "Nagios Web Frontend Username        : ${txtcyn}nagiosadmin${txtrst}"
echo "Nagios Web Frontend Username : nagiosadmin" 2> /dev/null  >> $log
echo "Nagios Web Frontend Password        : ${txtcyn}***********${txtrst}"
echo "Nagios Web Frontend Password : ***********" 2> /dev/null  >> $log
echo "Nagios Installation Directory       : ${txtcyn}/usr/local/nagios/${txtrst}"
echo "Nagios Installation Directory ' /usr/local/nagios/ '" 2> /dev/null  >> $log
echo "Nagios Main Configuration File      : ${txtcyn}/usr/local/nagios/etc/nagios.cfg${txtrst}"
echo "Nagios Main Configuration File ' /usr/local/nagios/etc/nagios.cfg '" 2> /dev/null  >> $log
echo "Nagios Object configuration Files   : ${txtcyn}/usr/local/nagios/etc/objects/${txtrst}"
echo "Nagios Object configuration Files: /usr/local/nagios/etc/objects/ '" 2> /dev/null  >> $log
echo "Nagios Apache Configuration File    : ${txtcyn}/etc/httpd/conf.d/nagios.conf${txtrst} ${txtrst} (For Redhat Based: CentOS, AlmaLinux, RockyLinux, Fedora)
                                    : ${txtcyn}/etc/apache2/sites-enabled/nagios.conf${txtrst} ${txtrst} (For Ubuntu/Debian)                                                                                                  : ${txtcyn}/etc/apache2/vhosts.d/nagios.conf${txtrst} (For OpenSUSE)"
echo "Nagios Apache Configuration File ' /etc/httpd/conf.d/nagios.conf '" 2> /dev/null  >> $log
sleep 2

echo
echo "${txtpur}Note${txtrst}"
sleep 2
echo "${txtbld}If you can't display the Nagios application in your browser, ${txtrst}"
echo "${txtbld}it means that the firewall and/or selinux application is still enable in your server.${txtrst}"
sleep 2

echo
echo "${txtred} ********                   Please change Contacts in                 ******** ${txtrst}"
echo "${txtred} ********          /usr/local/nagios/etc/objects/contacts.cfg         ******** ${txtrst}"
echo "${txtred} ******** Check Nagios installation Log File in /tmp/nagios_setup.log ******** ${txtrst}"
echo ""
sleep 2

echo " ${txtgrn}     ********** Thank You For Using All in One Nagios Script ********** ${txtrst}"
echo "              ${txtgrn}     ******** sysnotecom@gmail.com ******** ${txtrst}"
echo "                     ${txtgrn}     ****** Thank You ****** ${txtrst}"
echo

echo " ********** Thank You For Using All in One Nagios Script ********** " 2> /dev/null >> $log
echo "" 2> /dev/null  >> $log
echo "                  ******** sysnotecom@gmail.com ******** " 2> /dev/null  >> $log
echo
echo
sleep 3
cd ..
rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log*
exit 0
sleep 2
echo
echo
}

check() {
if [ $? != 0 ]
then
echo
echo "${txtred}I am sorry, I cannot continue the process because there was a problem. Please fix it first. ${txtrst}"
stop
thankyou
fi
}



####################################################################
#  _____           _        _ _     _   _             _            #
# |_   _|         | |      | | |   | \ | |           (_)           #
#   | |  _ __  ___| |_ __ _| | |   |  \| | __ _  __ _ _  ___  ___  #
#   | | | '_ \/ __| __/ _` | | |   | . ` |/ _` |/ _` | |/ _ \/ __| #
#  _| |_| | | \__ \ || (_| | | |   | |\  | (_| | (_| | | (_) \__ \ #
# |_____|_| |_|___/\__\__,_|_|_|   |_| \_|\__,_|\__, |_|\___/|___/ #
#                                                __/ |             #
#                                               |___/              #
#                                                                  #
####################################################################

nagiosplugin_centos_update() {
echo "${txtylw}Extract package Nagios plugin${txtrst}"
sleep 2
tar -zxvf $nagios_plugin;check
echo "${txtgrn}Done${txtrst}";sleep 2
echo "Extract package Nagios plugin successfully" 2> /dev/null  >> $log
echo
echo "${txtylw}Compile Nagios plugins update version${txtrst}"
sleep 2
cd $folder_plugin
./configure --with-nagios-user=nagios --with-nagios-group=nagios;check;make;check;make install;check;
echo "Compile Nagios plugins update version successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2

echo
echo "${txtylw}Adding Nagios to the list of system services${txtrst}"
systemctl enable apache2 2>/dev/null
systemctl enable nagios 2>/dev/null
systemctl enable httpd 2>/dev/null
chkconfig --add nagios 2>/dev/null
chkconfig --level 345 nagios on 2>/dev/null
chkconfig --add httpd 2>/dev/null
chkconfig --level 345 httpd on 2>/dev/null
sleep 1
echo "${txtgrn}Done${txtrst}"
echo

echo "Adding Nagios to the list of system services successfully" 2> /dev/null  >> $log
echo "${txtylw}Verify Nagios configuration files${txtrst}"
sleep 2
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg;check;
echo "Verify Nagios configuration files successfullyy" 2> /dev/null >> $log
sleep 1
echo "${txtgrn}Done${txtrst}"

echo
echo
echo "${txtylw}Restarting Nagios Service${txtrst}"
sleep 1
systemctl restart nagios.service 2>/dev/null
service nagios start 2>/dev/null
echo "Restarting Nagios Service successfully" 2> /dev/null  >> $log
sleep 1
echo "${txtgrn}Done${txtrst}"
echo
finish
echo
}



nagiosplugin_233() {
echo
echo "${txtylw}Extract package Nagios plugins${txtrst}"
sleep 2
tar -zxvf nagios-plugins-2.3.3.tar.gz;check
echo "Extract package Nagios plugins successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo
echo "${txtylw}Compile Nagios plugins version 2.3.3${txtrst}"
sleep 2
cd nagios-plugins-2.3.3;
./configure --with-nagios-user=nagios --with-nagios-group=nagios;check;echo;sleep1;make;check;echo;sleep1;make install;check;echo;sleep 1;
echo "Compile Nagios plugins version 2.3.3 successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo
echo "${txtylw}Adding Nagios to the list of system services${txtrst}"
echo
sleep 2
systemctl enable apache2 2>/dev/null
systemctl enable nagios 2>/dev/null
systemctl enable httpd 2>/dev/null
chkconfig --add nagios 2>/dev/null
chkconfig --level 345 nagios on 2>/dev/null
chkconfig --add httpd 2>/dev/null
chkconfig --level 345 httpd on 2>/dev/null
echo "Adding Nagios to the list of system services successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
echo
echo "${txtylw}Verify Nagios configuration files${txtrst}"
sleep 2
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg;check;
echo "Verify Nagios configuration files successfullyy" 2> /dev/null >> $log
echo ""
echo "${txtylw}Restarting Nagios Service${txtrst}"
sleep 1
systemctl restart nagios.service 2>/dev/null
service nagios start 2>/dev/null
echo "Restarting Nagios Service successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
echo
sleep 3
finish
echo
}

nagioscore_centos_update() {
echo "${txtylw}Extract package Nagios${txtrst}"
sleep 2
tar -zxvf $nagios_core
check
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Extract package Nagios successfully" 2> /dev/null >> $log
echo;echo
echo "${txtylw}Adding user and group for nagios${txtrst}"
sleep 2
useradd -m nagios;groupadd nagcmd;usermod -a -G nagcmd nagios;usermod -a -G nagcmd apache
echo "Adding user and group for nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2;echo
echo "${txtylw}Compiling Nagios${txtrst}"
sleep 2
cd $folder_nagios;./configure --with-command-group=nagcmd;check;echo;sleep 1;make all;echo;sleep 1;check;make install;echo;sleep 1;check;make install-init;echo;sleep 1;check;make install-commandmode;echo;sleep 1;check;make install-config;echo;sleep 1;check;make install-webconf;echo;sleep 1;check;
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
echo "${txtylw}Creating a NAGIOSADMIN account for logging into the Nagios web interface.${txtrst}"
echo "${txtylw}Please enter your password below & remember the password you assign to this account you will need it later.${txtrst}"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;check;
sleep 2
echo "Creating a NAGIOSADMIN account Successfull" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Restarting Apache Service${txtrst}"
sleep 1
cp /lib/systemd/system/nagios.service /etc/systemd/system 2>/dev/null
systemctl restart apache2 2>/dev/null
systemctl restart httpd 2>/dev/null
service httpd restart 2>/dev/null
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Restarting Apache Service Successfull" 2> /dev/null >> $log
sleep 2
echo
echo
echo "${txtgrn}Nagios core latest version has been installed !!!${txtrst}"
install_plugin_centos
sleep 2
echo "Nagios core latest version has been installed" 2> /dev/null >> $log
}


nagioscore_centos_446() {
echo "${txtylw}Extract package Nagios${txtrst}"
sleep 2
tar -zxvf nagios-4.4.6.tar.gz;check
sleep 2
echo "${txtgrn}Done${txtrst}"
echo "Extract package Nagios successfully" 2> /dev/null >> $log
echo;echo
echo "${txtylw}Adding user and group for nagios${txtrst}"
sleep 2
useradd -m nagios;groupadd nagcmd;usermod -a -G nagcmd nagios;usermod -a -G nagcmd apache
echo "Adding user and group for nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
echo;echo
echo "${txtylw}Compiling Nagios${txtrst}"
sleep 2
cd nagios-4.4.6;./configure --with-command-group=nagcmd;check;echo;sleep 1;make all;check;echo;sleep 1;make install;check;echo;sleep 1make install-init;check;echo;sleep 1;make install-config;check;echo;sleep 1;make install-commandmode;check;echo;sleep 1;make install-webconf;check;echo;sleep 1;
echo "Compiling Nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Creating a NAGIOSADMIN account for logging into the Nagios web interface.${txtrst}"
echo "${txtylw}Please enter your password below & remember the password you assign to this account you will need it later.${txtrst}"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;check;
sleep 2
echo "Creating a NAGIOSADMIN account successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Restarting Apache Service${txtrst}"
sleep 1
cp /lib/systemd/system/nagios.service /etc/systemd/system 2>/dev/null
systemctl restart apache2 2>/dev/null
systemctl restart httpd 2>/dev/null
service httpd restart 2>/dev/null
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Restarting Apache Service successfully" 2> /dev/null >> $log
echo;echo
echo "${txtgrn}Congratulation, Nagios version 4.4.6 has been installed.${txtrst}"
sleep 2
echo "Nagios core version 4.4.6 has been installed" 2> /dev/null >> $log
install_plugin_centos
sleep 2
echo "Nagios core update version has been installed" 2> /dev/null >> $log
}




nagioscore_ubuntu_446() {
echo "${txtylw}Extract package Nagios${txtrst}"
sleep 2
tar -zxvf nagios-4.4.6.tar.gz;check
sleep 2
echo "${txtgrn}Done${txtrst}"
echo "Extract package Nagios successfully" 2> /dev/null >> $log
echo;echo
echo "${txtylw}Adding user and group for nagios${txtrst}"
sleep 2
useradd -m nagios;groupadd nagcmd;usermod -a -G nagcmd nagios;usermod -a -G nagcmd www-data
echo "Adding user and group for nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
echo;echo
echo "${txtylw}Compiling Nagios${txtrst}"
sleep 2
cd nagios-4.4.6;./configure --with-command-group=nagcmd --with-httpd-conf=/etc/apache2/sites-enabled;check;echo;sleep 1;make all;check;echo;sleep 1;make install;check;echo;sleep 1;make install-init;check;echo;sleep 1;make install-daemoninit;check;echo;sleep 1;make install-config;check;echo;sleep 1;make install-commandmode;check;echo;sleep 1;make install-webconf;check;echo;sleep 1;a2enmod rewrite;check;echo;sleep 1;a2enmod cgi;check;echo;sleep 1;
echo "Compiling Nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Creating a NAGIOSADMIN account for logging into the Nagios web interface.${txtrst}"
echo "${txtylw}Please enter your password below & remember the password you assign to this account you will need it later.${txtrst}"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;check;
sleep 2
echo "Creating a NAGIOSADMIN account successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Restarting Apache Service${txtrst}"
sleep 1
systemctl restart apache2 2>/dev/null
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Restarting Apache Service successfully" 2> /dev/null >> $log
echo;echo
echo "${txtgrn}Congratulation, Nagios version 4.4.6 has been installed.${txtrst}"
sleep 2
echo "Nagios core version 4.4.6 has been installed" 2> /dev/null >> $log
install_plugin_centos
sleep 2
echo "Nagios core update version has been installed" 2> /dev/null >> $log
}


nagioscore_suse_446() {
echo "${txtylw}Extract package Nagios${txtrst}"
sleep 2
tar -zxvf nagios-4.4.6.tar.gz;check
sleep 2
echo "${txtgrn}Done${txtrst}"
echo "Extract package Nagios successfully" 2> /dev/null >> $log
echo;echo
echo "${txtylw}Adding user and group for nagios${txtrst}"
sleep 2
useradd -m nagios;groupadd nagcmd;usermod -a -G nagcmd nagios;usermod -a -G nagcmd www-data
echo "Adding user and group for nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
echo;echo
echo "${txtylw}Compiling Nagios${txtrst}"
sleep 2
cd nagios-4.4.6;./configure --with-command-group=nagcmd --with-httpd-conf=/etc/apache2/vhosts.d;check;echo;sleep 1;make all;check;echo;sleep 1;make install-groups-users;check;echo;sleep 1;make install;check;echo;sleep 1;make install-init;check;echo;sleep 1;make install-daemoninit;check;echo;sleep 1;make install-config;check;echo;sleep 1;make install-commandmode;check;echo;sleep 1;make install-webconf;check;echo;sleep 1;/usr/sbin/a2enmod rewrite;echo;sleep 1;/usr/sbin/a2enmod cgi;echo;sleep 1;/usr/sbin/a2enmod version;echo;sleep 1;/usr/sbin/a2enmod php7;echo;sleep 1;
echo "Compiling Nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Creating a NAGIOSADMIN account for logging into the Nagios web interface.${txtrst}"
echo "${txtylw}Please enter your password below & remember the password you assign to this account you will need it later.${txtrst}"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;check;
sleep 2
echo "Creating a NAGIOSADMIN account successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Restarting Apache Service${txtrst}"
sleep 1
sudo firewall-cmd --zone=public --add-port=80/tcp 2>/dev/null
firewall-cmd --zone=public --add-port=80/tcp --permanent 2>/dev/null
systemctl restart apache2 2>/dev/null
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Restarting Apache Service successfully" 2> /dev/null >> $log
echo;echo
echo "${txtgrn}Congratulation, Nagios version 4.4.6 has been installed.${txtrst}"
sleep 2
echo "Nagios core version 4.4.6 has been installed" 2> /dev/null >> $log
install_plugin_centos
sleep 2
echo "Nagios core update version has been installed" 2> /dev/null >> $log
}












nagioscore_suse_update() {
echo "${txtylw}Extract package Nagios${txtrst}"
sleep 2
tar -zxvf $nagios_core
check
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Extract package Nagios successfully" 2> /dev/null >> $log
echo;echo
echo "${txtylw}Adding user and group for nagios${txtrst}"
sleep 2
useradd nagios;groupadd nagcmd;usermod -a -G nagcmd nagios;usermod -a -G nagcmd wwwrun
echo "Adding user and group for nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2;echo
echo "${txtylw}Compiling Nagios${txtrst}"
sleep 2
cd $folder_nagios;./configure --with-command-group=nagcmd --with-httpd-conf=/etc/apache2/vhosts.d;check;echo;sleep 1;make all;echo;sleep 1;check;make install-groups-users;echo;sleep 1;make install;check;echo;sleep 1;make install-init;check;echo;sleep 1;echo;sleep 1;make install-daemoninit;check;echo;sleep 1;make install-config;check;echo;sleep 1;make install-commandmode;check;echo;sleep 1;make install-webconf;check;echo;sleep 1;
/usr/sbin/a2enmod rewrite;check;echo;sleep 1;/usr/sbin/a2enmod cgi;check;echo;sleep 1;/usr/sbin/a2enmod version;check;echo;sleep 1;/usr/sbin/a2enmod php7;check;echo;sleep 1;
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
echo "${txtylw}Creating a NAGIOSADMIN account for logging into the Nagios web interface.${txtrst}"
echo "${txtylw}Please enter your password below & remember the password you assign to this account you will need it later.${txtrst}"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;check
sleep 2
echo "Creating a NAGIOSADMIN account Successfull" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Restarting Apache Service${txtrst}"
sleep 1
systemctl restart apache2 2>/dev/null
systemctl restart httpd 2>/dev/null
service httpd restart 2>/dev/null
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Restarting Apache Service Successfull" 2> /dev/null >> $log
sleep 2
echo
echo
echo "${txtgrn}Nagios core latest version has been installed !!!${txtrst}"
install_plugin_centos
sleep 2
echo "Nagios core latest version has been installed" 2> /dev/null >> $log
}



nagioscore_ubuntu_update() {
echo "${txtylw}Extract package Nagios${txtrst}"
sleep 2
tar -zxvf $nagios_core
check
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Extract package Nagios successfully" 2> /dev/null >> $log
echo;echo
echo "${txtylw}Adding user and group for nagios${txtrst}"
sleep 2
useradd nagios;groupadd nagcmd;usermod -a -G nagcmd nagios;usermod -a -G nagcmd www-data
echo "Adding user and group for nagios successfully" 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2;echo
echo "${txtylw}Compiling Nagios${txtrst}"
sleep 2
cd $folder_nagios;./configure --with-command-group=nagcmd --with-httpd-conf=/etc/apache2/sites-enabled;check;echo;sleep 1;make all;check;echo;sleep 1;make install;check;echo;sleep 1;make install-init;check;echo;sleep 1;make install-daemoninit;check;echo;sleep 1;make install-config;check;echo;sleep 1;make install-commandmode;check;echo;sleep 1;make install-webconf;check;echo;sleep 1;a2enmod rewrite;check;echo;sleep 1;a2enmod cgi;check;echo;sleep 1;
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
echo "${txtylw}Creating a NAGIOSADMIN account for logging into the Nagios web interface.${txtrst}"
echo "${txtylw}Please enter your password below & remember the password you assign to this account you will need it later.${txtrst}"
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;check
sleep 2
echo "Creating a NAGIOSADMIN account Successfull " 2> /dev/null >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo;echo
echo "${txtylw}Restarting Apache Service${txtrst}"
sleep 1
systemctl restart apache2 2>/dev/null
systemctl restart httpd 2>/dev/null
service httpd restart 2>/dev/null
echo "${txtgrn}Done${txtrst}"
sleep 2
echo "Restarting Apache Service Successfull" 2> /dev/null  >> $log
sleep 2
echo
echo
echo "${txtgrn}Nagios core latest version has been installed !!!${txtrst}"
install_plugin_centos
sleep 2
echo "Nagios core latest version has been installed" 2> /dev/null >> $log
}


install_ubuntu() {
############ Installation Some Packages Needed to Install Nagios  ################

echo "${txtylw}Installation Some Packages Needed to Install Nagios.${txtrst}"
list=`ls -l | grep php.txt | awk '{print $5}'`

sleep 1
apt update
apt-get install -y php libgd-dev php-gd autoconf apache2 libapache2-mod-php automake make openssl autoconf gcc libc6 libmcrypt-dev make unzip libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext;check
sleep 1
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
nagios_ubuntu
}



nagios_ubuntu() {
############ Search latest version of Nagios Core  ################
echo "${txtylw}Search latest version of Nagios Core${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
sleep 2
echo
cd $path;wget --no-check-certificate -q https://www.nagios.org/downloads/nagios-core/thanks/?t=1504034794 2> /dev/null


############ if fails to find the last version, download version 4.4.6 ################
latest_nagios=`cat index.html* 2>/dev/null  | grep "assets.nagios.com/downloads/nagioscore/releases" | sed -n '1p' | awk '{print $6}' | sed -e 's/<[^()]*>//g' | sed -e 's/\/[^()]*\///g' | sed -e 's/\"[^()]*\">//g' | sed -e 's/href=//g' `

echo $latest_nagios | grep tar.gz > targz.txt

version=`echo $latest_nagios | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

count=`ls -al | grep targz.txt | awk '{print $5}' `
#if [ $count != 0 ]
if [ $count != 0 ]
then
        echo "${txtcyn}Latest version of Nagios core is $version${txtrst}"
        sleep 3
        rm -rf index.html*
        echo
        nagios_core=`echo $latest_nagios`
        folder_nagios=`echo $nagios_core | sed -e 's/.tar.gz//g'`
        echo "${txtylw}Downloading latest version of Nagios core ...${txtrst}";sleep 2;echo
        echo "Downloading Nagios-Latest-version" 2> /dev/null >> $log
        sleep 2
        cd $path;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/$nagios_core
        count=`ls -1 nagios* 2>/dev/null | wc -l `
        if [ $count != 0 ]
                then
                        nagioscore_ubuntu_update
                else
                         echo ${txtred}I detected there is a problem when I want to check the latest version of Nagios.${txtrst}
                         sleep 2
                         echo ${txtylw}So, I will install Nagios core version 4.4.6.${txtrst}

                         while true
                         do
                                 echo
                                 read -p "Are you sure want to continue (y/n)? " answer
                                 case $answer in
                                 [yY]* ) echo "${txtpur}Okay, I will download Nagios version 4.4.6 from official web.${txtrst}"
                                         sleep 2
                                         cd $path;wget --no-check-certificate 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                         echo "${txtgrn}Nagios version 4.4.6 has been download and we will install it to your server${txtrst}"
                                         sleep 1
                                         nagioscore_ubuntu_446
                                 break;;
                                 [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log*
                                         thankyou
                                         break;;
                                    * )  echo "Just enter Y or N, please.";;
                                 esac
                         done
        fi
else
        echo ${txtred}I detected there is a problem when I want to check the latest version of Nagios.${txtrst}
        sleep 2
        echo ${txtylw}So, I will install Nagios core version 4.4.6.${txtrst}

        while true
        do
        echo
        read -p "Are you sure want to continue (y/n)? " answer
        case $answer in
                [yY]* ) echo "${txtpur}Okay, I will download Nagios version 4.4.6 from official web.${txtrst}"
                        sleep 2
                        echo
                        cd $path;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
                        count=`ls -1 nagios-*.tar.gz  2>/dev/null | wc -l`
                        if [ $count != 0 ]
                        then
                                nagioscore_ubuntu_446
                        else
                                echo;
                                sleep 2;
                                echo "${txtylw}Wait a minute, I look for another source ...${txtrst}";sleep 2
                                cd $path;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                echo "${txtgrn}Nagios version 4.4.6 has been download and we will install it to your server${txtrst}"
                                echo
                                sleep 2
                                nagioscore_ubuntu_446
                        fi
                break;;

                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log*
                        thankyou
                        break;;
                * )     echo "Just enter Y or N, please.";;
        esac
done
fi
}






install_suse() {
############ Installation Some Packages Needed to Install Nagios  ################

echo "${txtylw}Installation Some Packages Needed to Install Nagios.${txtrst}"
list=`ls -l | grep php.txt | awk '{print $5}'`

sleep 1
zypper --non-interactive install autoconf gcc glibc make wget unzip apache2 apache2-utils php7 apache2-mod_php7 gd gd-devel libopenssl-devel gettext gettext-runtime automake net-snmp perl-Net-SNMP;check
sleep 1
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
nagios_suse
}

nagios_suse() {
############ Search latest version of Nagios Core  ################
echo "${txtylw}Search latest version of Nagios Core${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
sleep 2
echo
cd $path;wget --no-check-certificate -q https://www.nagios.org/downloads/nagios-core/thanks/?t=1504034794 2> /dev/null


############ if fails to find the last version, download version 4.4.6 ################
latest_nagios=`cat index.html* 2>/dev/null  | grep "assets.nagios.com/downloads/nagioscore/releases" | sed -n '1p' | awk '{print $6}' | sed -e 's/<[^()]*>//g' | sed -e 's/\/[^()]*\///g' | sed -e 's/\"[^()]*\">//g' | sed -e 's/href=//g' `


version=`echo $latest_nagios | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

count=`ls -1 index.html* 2>/dev/null | wc -l `
if [ $count != 0 ]
then
        echo "${txtcyn}Latest version of Nagios core is $version${txtrst}"
        sleep 3
        rm -rf index.html*
        echo
        nagios_core=`echo $latest_nagios`
        folder_nagios=`echo $nagios_core | sed -e 's/.tar.gz//g'`
        echo "${txtylw}Downloading latest version of Nagios core ...${txtrst}";sleep 2;echo
        echo "Downloading Nagios-Latest-version" 2> /dev/null >> $log
        sleep 2
        cd $path;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/$nagios_core
        count=`ls -1 nagios*.tar.gz 2>/dev/null | wc -l `
        if [ $count != 0 ]
                then
                        nagioscore_suse_update
                else
                         echo ${txtred}I detected there is a problem when I want to check the latest version of Nagios.${txtrst}
                         sleep 2
                         echo ${txtylw}So, I will install Nagios core version 4.4.6.${txtrst}

                         while true
                         do
                                echo
                                read -p "Are you sure want to continue (y/n)? " answer
                                case $answer in
                                [yY]* ) echo "${txtpur}Okay, I will download Nagios version 4.4.6 from official web${txtrst}"
                                        sleep 2
                                        cd $path;wget --no-check-certificate 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                        echo "${txtgrn}Nagios version 4.4.6 has been download and we will install it to your server${txtrst}"
                                        sleep 1
                                        nagioscore_suse_446
                                        break;;
                                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log*
                                        thankyou
                                        break;;
                                    * ) echo "Just enter Y or N, please.";;
                                esac
                         done
        fi
else
        echo ${txtred}I detected there is a problem when I want to check the latest version of Nagios.${txtrst}
        sleep 2
        echo ${txtylw}So, I will install Nagios core version 4.4.6.${txtrst}

        while true
        do
                echo
                read -p "Are you sure want to continue (y/n)? " answer
                case $answer in
                   [yY]* )   echo "${txtpur}Okay, I will download Nagios version 4.4.6 from official web.${txtrst}"
                             sleep 2
                             echo
                             cd $path;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
                             sleep 2
                             count=`ls -1 nagios-*.tar.gz  2>/dev/null | wc -l`
                             if [ $count != 0 ]
                             then
                                 nagioscore_suse_446
                             else
                                 echo;
                                 echo "${txtylw}Wait a minute, I look for another source ...${txtrst}";sleep 2
                                 cd $path;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                 echo "${txtgrn}Nagios version 4.4.6 has been download and we will install it to your server${txtrst}"
                                 echo
                                 sleep 2
                                 nagioscore_suse_446
                             fi
                                break;;
                   [nN]* )   sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log*
                             thankyou
                             break;;
                       * )   echo "Just enter Y or N, please.";;
                esac
        done
fi
}




install_plugin_centos () {

############ Search latest version of Nagios Plugin  ################

echo
echo "${txtylw}I will install Nagios Plugins.${txtrst}"
echo "${txtylw}Search latest version of Nagios Plugins.${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
sleep 3

wget -q --no-check-certificate https://nagios-plugins.org/download/
cat index.html | grep plugins | grep -v sha1 | head -n 1 | sed 's/.*href=//' | sed 's/class.*//' | sed 's/\"\>.*//' | awk -F\> '{print $1}' | sed '1s/^.//' | sed '$ s/.$//' > latest_plugin.txt

size=`ls -al latest_plugin.txt | awk '{print $5}'`

version=`cat latest_plugin.txt |  sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

echo

############ if fails to find the last version, download version 2.3.3 ################
nagios_plugin=`cat latest_plugin.txt`
folder_plugin=`echo $nagios_plugin | sed -e 's/.tar.gz//g'` 2> /dev/null
echo "${txtcyn}Latest version of Nagios plugin is $version${txtrst}"
sleep 2
echo
echo "${txtylw}I will Download the latest version of Nagios Plugins${txtrst}";sleep 2;echo
cd $path;wget --no-check-certificate https://nagios-plugins.org/download/$nagios_plugin
sleep 2
echo

count=`ls -1 nagios-plugin*.tar.gz  2>/dev/null | wc -l`
if [ $count != 0 ]
then
        sleep 3
        echo
        nagiosplugin_centos_update

else
        echo ${txtred}I detected there is a problem when I want to download latest Nagios Plugins version from official web.${txtrst}
        sleep 2
        echo ${txtylw}I will install Nagios Plugins version 2.3.3 from another source.${txtrst}

        while true
        do
        echo
        read -p "Are you sure want to continue (y/n)? " answer
        case $answer in
                [yY]* ) echo "${txtpur}Okay, I will install Nagios Plugins version 2.3.3${txtrst}"
                        sleep 2
                                cd $path;wget --no-check-certificate 'https://archive.org/details/nagios-plugins-2.3.3.tar' -O nagios-plugins-2.3.3.tar.gz 2> /dev/null
                                echo "${txtgrn}Nagios Plugin version 2.3.3 has been download and we will install it to your server${txtrst}"
                                sleep 2
                                nagiosplugin_233
                break;;
                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log*
                        thankyou
                break;;
                * )     echo "Just enter Y or N, please.";;
        esac
done
fi
}










install_centos() {
############ Installation Some Packages Needed to Install Nagios  ################

#Check Firewall
firewall-cmd --zone=public --add-port=80/tcp --permanent 2> /dev/null
firewall-cmd --reload  2> /dev/null
setenforce 0  2> /dev/null


echo "${txtylw}Installation Some Packages Needed to Install Nagios.${txtrst}"
list=`ls -l | grep php.txt | awk '{print $5}'`

sleep 1
yum install -y php php-devel php-gd httpd gcc glibc glibc-common gd gd-devel make net-snmp-* wget zip unzip tar;check
sleep 1
echo "${txtgrn}Done${txtrst}"
echo
sleep 1

cat /etc/httpd/conf/httpd.conf | grep index.php > httpd.txt
httpd=`ls -al httpd.txt | awk '{print $5}'`

if [ $httpd == 0 ]
then
        sed -i 's/\index.html\b/& index.php/' /etc/httpd/conf/httpd.conf
fi

sleep 2
nagios_centos
}

nagios_centos() {
############ Search latest version of Nagios Core  ################
echo "${txtylw}Search latest version of Nagios Core${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
sleep 2
echo
cd $path;wget --no-check-certificate -q https://www.nagios.org/downloads/nagios-core/thanks/?t=1504034794 2> /dev/null


############ if fails to find the last version, download version 4.4.6 ################
latest_nagios=`cat index.html* 2>/dev/null  | grep "assets.nagios.com/downloads/nagioscore/releases" | sed -n '1p' | awk '{print $6}' | sed -e 's/<[^()]*>//g' | sed -e 's/\/[^()]*\///g' | sed -e 's/\"[^()]*\">//g' | sed -e 's/href=//g' `


version=`echo $latest_nagios | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

count=`ls -1 index.html* 2>/dev/null | wc -l `
if [ $count != 0 ]
then
        echo "${txtcyn}Latest version of Nagios core is $version${txtrst}"
        sleep 3
        rm -rf index.html*
        echo
        nagios_core=`echo $latest_nagios`
        folder_nagios=`echo $nagios_core | sed -e 's/.tar.gz//g'`
        echo "${txtylw}Downloading latest version of Nagios core...${txtrst}";sleep 2;echo
        echo "Downloading Nagios-Latest-version" 2> /dev/null >> $log
        sleep 2
        cd $path;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/$nagios_core
        count=`ls -1 nagios* 2>/dev/null | wc -l `
        if [ $count != 0 ]
                then
                        nagioscore_centos_update
                else
                         echo ${txtred}I detected there is a problem when I want to check the latest version of Nagios.${txtrst}
                         sleep 2
                         echo ${txtylw}So, I will install Nagios core version 4.4.6.${txtrst}

                         while true
                         do
                                echo
                                read -p "Are you sure want to continue (y/n)? " answer
                                case $answer in
                                     [yY]* )    echo "${txtpur}Okay, I will download Nagios version 4.4.6 from official web.${txtrst}"
                                                sleep 2
                                                cd $path;wget --no-check-certificate 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                                echo "${txtgrn}Nagios version 4.4.6 has been download and we will install it to your server${txtrst}"
                                                sleep 1
                                                nagioscore_centos_446
                                                break;;
                                     [nN]* )    sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                                                thankyou
                                                break;;
                                         * )    echo "Just enter Y or N, please.";;
                                esac
                         done
        fi
else
        echo ${txtred}I detected there is a problem when I want to check the latest version of Nagios.${txtrst}
        sleep 2
        echo ${txtylw}So, I will install Nagios core version 4.4.6.${txtrst}

        while true
        do
                echo
                read -p "Are you sure want to continue (y/n)? " answer
                case $answer in
                     [yY]* )   echo "${txtpur}Okay, I will download Nagios version 4.4.6 from official web.${txtrst}"
                               sleep 2
                               echo
                               cd $path;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
                               count=`ls -1 nagios-*.tar.gz  2>/dev/null | wc -l`
                               if [ $count != 0 ]
                               then
                                        nagioscore_centos_446
                               else
                                        echo;
                                        echo "${txtylw}Wait a minute, I look for another source ...${txtrst}";sleep 2
                                        cd $path;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                        echo "${txtgrn}Nagios version 4.4.6 has been download and we will install it to your server${txtrst}"
                                        echo
                                        sleep 2
                                        nagioscore_centos_446
                               fi
                               break;;
                     [nN]* )   sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                               thankyou
                               break;;
                        * )    echo "Just enter Y or N, please.";;
                esac
        done
fi
}

install_plugin_centos () {

############ Search latest version of Nagios Plugin  ################

echo
echo "${txtylw}I will install Nagios Plugins.${txtrst}"
echo "${txtylw}Search latest version of Nagios Plugins.${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
sleep 3

wget -q --no-check-certificate https://nagios-plugins.org/download/
cat index.html | grep plugins | grep -v sha1 | head -n 1 | sed 's/.*href=//' | sed 's/class.*//' | sed 's/\"\>.*//' | awk -F\> '{print $1}' | sed '1s/^.//' | sed '$ s/.$//' > latest_plugin.txt

size=`ls -al latest_plugin.txt | awk '{print $5}'`

version=`cat latest_plugin.txt |  sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

echo

############ if fails to find the last version, download version 2.3.3 ################
nagios_plugin=`cat latest_plugin.txt`
folder_plugin=`echo $nagios_plugin | sed -e 's/.tar.gz//g'` 2> /dev/null
echo "${txtcyn}Latest version of Nagios plugin is $version${txtrst}"
sleep 2
echo
echo "${txtylw}I will Download the latest version of Nagios Plugins${txtrst}";sleep 2;echo
cd $path;wget --no-check-certificate https://nagios-plugins.org/download/$nagios_plugin
sleep 2
echo

count=`ls -1 nagios-plugin*.tar.gz  2>/dev/null | wc -l`
if [ $count != 0 ]
then
        sleep 3
        echo
        nagiosplugin_centos_update

else
        echo ${txtred}I detected there is a problem when I want to download latest Nagios Plugins version from official web.${txtrst}
        sleep 2
        echo ${txtylw}I will install Nagios Plugins version 2.3.3 from another source.${txtrst}

        while true
        do
                echo
                read -p "Are you sure want to continue (y/n)? " answer
                case $answer in
                     [yY]* )    echo "${txtpur}Okay, I will install Nagios Plugins version 2.3.3${txtrst}"
                                sleep 2
                                cd $path;wget --no-check-certificate 'https://archive.org/details/nagios-plugins-2.3.3.tar' -O nagios-plugins-2.3.3.tar.gz 2> /dev/null
                                echo "${txtgrn}Nagios Plugin version 2.3.3 has been download and we will install it to your server${txtrst}"
                                sleep 2
                                nagiosplugin_233
                                break;;
                     [nN]* )    sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                                thankyou
                                break;;
                        * )     echo "Just enter Y or N, please.";;
                esac
        done
fi
}

install_nagios_centos () {
install_centos
}

check_internet () {
############ Checking Internet  ################
echo "${txtylw}I will check whether the server is connected to the internet or not. ${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
ping -q -c5 google.com >> /dev/null
if [ $? = 0 ]
then
echo "${txtgrn}Great, Your server is connected to the internet${txtrst}"
echo "Your System is Connected to Internet" 2> /dev/null  >> $log
sleep 2
echo
else
echo "${txtred}Your server is not connected to the internet so the I can not continue to install Nagios.${txtrst}"
echo "${txtred}Please connect the internet first ...!${txtrst}"
echo "Please connect to the internet ..." 2> /dev/null >> $log
stop
fi
}

check_user () {
############ Checking account  ################
echo "${txtylw}Try to guess your account "
sleep 2
user=`whoami`
if [ $user = "root" ]
then
echo "${txtgrn}Good, your account is root${txtrst}"
echo "Your account is root" 2> /dev/null >> $log
echo
else
echo "${txtred}Please change first to root account${txtrst}"
echo "Please change first to root" 2> /dev/null >> $log
stop
fi
sleep 1
}

check_packet_centos () {
############ Checking Nagios  ################
echo "${txtylw}Try to check existing Nagios "

find / -name nagios.cfg > check_nagios.txt
size1=`ls -al | grep check_nagios.txt | awk '{print $5}'`
sleep 2

if [ $size1 != 0 ]
then
        echo "${txtgrn}It looks like you have installed Nagios. ${txtrst}"
        sleep 1
        echo "${txtgrn}Please, delete your Nagios first. ${txtrst}"
        rm -rf check_nagios.txt
        echo
        sleep 2
        exit
else
        echo "${txtcyn}Ok, I will install Nagios in your server as soon as possible. ${txtrst}"
        rm -rf check_nagios.txt
        sleep 2
        echo
        install_nagios_centos
fi

}


check_packet_ubuntu () {
############ Checking Ubuntu/Debian  ################
echo "${txtylw}Try to check existing Nagios "

find / -name nagios.cfg > check_nagios.txt
size1=`ls -al | grep check_nagios.txt | awk '{print $5}'`
sleep 2

if [ $size1 != 0 ]
then
        echo "${txtgrn}It looks like you have installed Nagios. ${txtrst}"
        sleep 1
        echo "${txtgrn}Please, delete your Nagios first. ${txtrst}"
        echo
        rm -rf check_nagios.txt
        sleep 2
        exit
else
        echo "${txtcyn}Ok, I will install Nagios in your server as soon as possible. ${txtrst}"
        rm -rf check_nagios.txt
        sleep 2
        echo
        install_ubuntu
fi

}


check_packet_opensuse () {
############ Checking OpenSUSE  ################
echo "${txtylw}Try to check existing Nagios "
find / -name nagios.cfg > check_nagios.txt
size1=`ls -al | grep check_nagios.txt | awk '{print $5}'`
sleep 2

if [ $size1 != 0 ]
then
        echo "${txtgrn}It looks like you have installed Nagios. ${txtrst}"
        sleep 1
        echo "${txtgrn}Please, delete your Nagios first. ${txtrst}"
        echo
        rm -rf check_nagios.txt
        sleep 2
        exit
else
        echo "${txtcyn}Ok, I will install Nagios in your server as soon as possible. ${txtrst}"
        rm -rf check_nagios.txt
        sleep 2
        echo
        install_suse
fi

}



check_os () {
############ Checking OS  ################
echo "${txtylw}Try to guess your operating system "
sleep 2
if [ -f /etc/debian_version ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep ^NAME | awk 'NR > 1 {print $1}' RS='"' FS='"'` `cat /etc/debian_version`${txtrst}"
sleep 2
echo
check_packet_ubuntu
echo
else

if [ -f /etc/redhat-release ]
then
echo "${txtgrn}Your Operating System is `cat /etc/redhat-release`"
sleep 2
echo
check_packet_centos
else

if [ -f /etc/SUSE-brand ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep PRETTY_NAME | sed 's/.*=//' | sed 's/^.//' | sed 's/.$//'`"
echo
sleep 2
check_packet_opensuse
echo
else

echo "${txtred}I think your OS is not Debian/Ubuntu or RedHat-Based (CentOS, AlmaLinux, RockyLinux) or openSUSE${txtrst}"
echo "${txtred}I am sorry, only work on Linux Debian/Ubuntu, RedHat-Based (CentOS, AlmaLinux, RockyLinux), and openSUSE${txtrst}"
echo "${txtred}So, I can not install Nagios in your server${txtrst}"
stop
fi
fi
fi
}

notice () {
############ Disable Firewall and SELinux  ################
echo
sleep 2
echo "${txtbld}The script will install Nagios Core from source code with using default folder (/usr/local/nagios)${txtrst}"
sleep 3
echo
echo
}

install_nagios () {
notice
check_internet
check_user
check_os
}






###################################################################
#  _____           _        _ _     _____  _             _        #
# |_   _|         | |      | | |   |  __ \| |           (_)       #
#   | |  _ __  ___| |_ __ _| | |   | |__) | |_   _  __ _ _ _ __   #
#   | | | '_ \/ __| __/ _` | | |   |  ___/| | | | |/ _` | | '_ \  #
#  _| |_| | | \__ \ || (_| | | |   | |    | | |_| | (_| | | | | | #
# |_____|_| |_|___/\__\__,_|_|_|   |_|    |_|\__,_|\__, |_|_| |_| #
#                                                   __/ |         #
#                                                  |___/          #
#                                                                 #
###################################################################

nagiosplugin_centos () {

nagiosplugin_centos_upgrade () {
echo "${txtylw}Extract package Nagios plugin${txtrst}"
sleep 2
tar -zxvf $nagios_plugin;check
echo "${txtgrn}Done${txtrst}"
echo "Extract package Nagios plugin successfully" 2> /dev/null  >> $log
echo
echo "${txtylw}Compile Nagios plugins update version${txtrst}"
sleep 2
cd $folder_plugin
./configure --with-nagios-user=nagios --with-nagios-group=nagios;check;make;check;make install;check;
echo "${txtgrn}Done${txtrst}"
echo "Compile Nagios plugins update version successfully" 2> /dev/null  >> $log
sleep 2

echo
echo "${txtylw}Adding Nagios to the list of system services${txtrst}"
systemctl enable apache2 2>/dev/null
systemctl enable nagios 2>/dev/null
systemctl enable httpd 2>/dev/null
chkconfig --add nagios 2>/dev/null
chkconfig --level 345 nagios on 2>/dev/null
chkconfig --add httpd 2>/dev/null
chkconfig --level 345 httpd on 2>/dev/null
sleep 1
echo "${txtgrn}Done${txtrst}"
echo "Adding Nagios to the list of system services successfully" 2> /dev/null  >> $log

echo
echo "${txtylw}Verify Nagios configuration files${txtrst}"
sleep 2
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg;check;
echo "Verify Nagios configuration files successfullyy" 2> /dev/null  >> $log
sleep 2
echo "${txtgrn}Done${txtrst}"

echo
echo
echo "${txtylw}Restarting Nagios Service${txtrst}"
sleep 1
systemctl restart nagios.service 2>/dev/null
service nagios start 2>/dev/null
echo "${txtgrn}Done${txtrst}"
echo "Restarting Nagios Service successfully" 2> /dev/null  >> $log
sleep 1
echo
echo
plugin_existing_version=`/usr/local/nagios/lib*/check_disk --version | awk '{print $2}'  | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//`
echo "${txtblu}Your Nagios Plugins version is $plugin_existing_version"${txtrst}
sleep 3
echo "${txtgrn}Done${txtrst}"
echo
thankyou
}

nagiosplugin_centos_233 () {
echo
echo "${txtylw}Extract package Nagios plugins${txtrst}"
sleep 2
tar -zxvf nagios-plugins-2.3.3.tar.gz;check
echo "Extract package Nagios plugins successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo
echo "${txtylw}Compile Nagios plugins version 2.3.3${txtrst}"
sleep 2
cd nagios-plugins-2.3.3;
./configure --with-nagios-user=nagios --with-nagios-group=nagios;check;echo;sleep1;make;check;echo;sleep1;make install;check;echo;sleep 1;
echo "${txtgrn}Done${txtrst}"
echo "Compile Nagios plugins version 2.3.3 successfully" 2> /dev/null  >> $log
sleep 2
echo
echo
echo "${txtylw}Adding Nagios to the list of system services${txtrst}"
sleep 2
systemctl enable apache2 2> /dev/null
systemctl enable nagios 2> /dev/null
systemctl enable httpd 2> /dev/null
chkconfig --add nagios 2> /dev/null
chkconfig --level 345 nagios on 2> /dev/null
chkconfig --add httpd 2> /dev/null
chkconfig --level 345 httpd on 2> /dev/null
echo "Adding Nagios to the list of system services successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
echo
echo "${txtylw}Verify Nagios configuration files${txtrst}"
sleep 2
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg;check;
echo "Verify Nagios configuration files successfullyy" 2> /dev/null  >> $log
echo ""
echo "${txtylw}Restarting Nagios Service${txtrst}"
sleep 1
systemctl restart nagios.service 2> /dev/null
service nagios start 2> /dev/null
sleep 2
echo "Restarting Nagios Service successfully" 2> /dev/null  >> $log
echo "${txtgrn}Done${txtrst}"
echo
plugin_existing_version=`/usr/local/nagios/lib*/check_disk --version | awk '{print $2}'  | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//`
echo "${txtgrn}Your Nagios Plugins version is $plugin_existing_version"${txtrst}
sleep 3
thankyou
cd ..;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt

}



check_latest_plugin () {
wget -q --no-check-certificate https://nagios-plugins.org/download/
cat index.html | grep plugins | grep -v sha1 | head -n 1 | sed 's/.*href=//' | sed 's/class.*//' | sed 's/\"\>.*//' | awk -F\> '{print $1}' | sed '1s/^.//' | sed '$ s/.$//' > latest_plugin.txt

size=`ls -al latest_plugin.txt | awk '{print $5}'`

version=`cat latest_plugin.txt |  sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`
}

check_latest_plugin

latest_plugin=`cat latest_plugin.txt`

existing_plugin=`/usr/local/nagios/lib*/check_ssh -V | awk '{print $2}' | sed 's/^.//'`

echo
echo "${txtylw}I will check exist plugin nagios version in your server. Please wait a minute ...${txtrst}";sleep 2
echo "${txtblu}Your Nagios Plugins version is $plugin_existing_version"${txtrst}
echo;sleep 2
echo "${txtylw}I will check latest plugin nagios version. Please wait a minute ...${txtgrn}";sleep 2
echo "${txtblu}Latest Nagios Plugins version is $plugin_latest_version${txtrst}";sleep 2
echo

echo "Test1"

if [ $existing_plugin -ge $latest_plugin ]
then
   echo "${txtgrn}Your existing Nagios Plugins version is up-to-date.${txtrst}"
   rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt check_latest_core.txt targz.txt wget-log* httpd.txt
   echo
sleep 3
elif [ $existing_plugin -lt $latest_plugin ]
then
    while true
    do
    echo "${txtred}Your existing plugin version is not update.${txtrst}"
    read -p "${txtylw}Are you sure want to update (y/n)?${txtrst} " answer
        echo
        case $answer in
                [yY]* ) sleep 1;echo;echo "${txtpur}Okay, I will upgrade your plugin nagios version to the latest version.${txtrst}"
                        echo "${txtylw}Please backup your Nagios configuration first and then if you finish backup, press any key to continue ... ${txtrst}";echo
                        read -n 1 -s -r;echo;sleep 2
                        echo "${txtcyn}Latest version of Nagios Plugins is `echo $plugin_latest_version` version${txtrst}"
                        echo "${txtylw}I will Download the latest version of Nagios Plugins${txtrst}";sleep 2;echo
                        cd $path;wget  --no-check-certificate https://nagios-plugins.org/download/$nagios_plugin
                        count=`ls -1 nagios* 2>/dev/null | wc -l `
                        if [ $count != 0 ]
                                then
                                echo
                                nagiosplugin_centos_upgrade
                        else
                        echo ${txtred}I detected there is a problem when download latest Nagios Plugins version in official website.${txtrst}
                        sleep 2
                        echo ${txtylw}I will install Nagios Plugins version 2.3.3 from another source.${txtrst}

                         while true
                         do
                         echo
                         read -p "Are you sure want to continue (y/n)? " answer
                         case $answer in
                                [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Plugins version 2.3.3${txtrst}"
                                        sleep 2
                                        echo "${txtylw}Downloading Nagios Plugins version 2.3.3 ...${txtrst}"
                                        cd $path;wget --no-check-certificate 'https://archive.org/details/nagios-plugins-2.3.3.tar/nagios-plugins-2.3.3.tar.gz' -O nagios-plugins-2.3.3.tar.gz
                                        echo "${txtgrn}Nagios Plugins version 2.3.3 has been download and we will install it to your server${txtrst}"
                                        sleep 1
                                        nagiosplugin_centos_233
                                break;;
                                [nN]* ) rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                                        thankyou
                                break;;
                         * )     echo "Just enter Y or N, please.";;
                         esac
                         done
        fi

                echo
                break;;

                [nN]* ) sleep 2
                rm -rf version.txt index_latest.html latest* latest nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt httpd.txt
                thankyou
                echo
                break;;
                * )     echo "Just enter Y or N, please.";;
        esac
done


fi
}








###############################################################################
#  _    _                           _          _   _             _            #
# | |  | |                         | |        | \ | |           (_)           #
# | |  | |_ __   __ _ _ __ __ _  __| | ___    |  \| | __ _  __ _ _  ___  ___  #
# | |  | | '_ \ / _` | '__/ _` |/ _` |/ _ \   | . ` |/ _` |/ _` | |/ _ \/ __| #
# | |__| | |_) | (_| | | | (_| | (_| |  __/   | |\  | (_| | (_| | | (_) \__ \ #
#  \____/| .__/ \__, |_|  \__,_|\__,_|\___|   |_| \_|\__,_|\__, |_|\___/|___/ #
#        | |     __/ |                                      __/ |             #
#        |_|    |___/                                      |___/              #
#                                                                             #
###############################################################################


upgrade_plugin () {
cat index.html | grep plugins | grep -v sha1 | head -n 1 | sed 's/.*href=//' | sed 's/class.*//' | sed 's/\"\>.*//' | awk -F\> '{print $1}' | sed '1s/^.//' | sed '     $ s/.$//' > latest_plugin.txt
echo "${txtpur}Okay, I will upgrade your nagios plugins version to the latest version.${txtrst}"
sleep 1
echo "${txtpur}I will backup your nagios to /usr/local/nagios-backup.${txtrst}"
sleep 2
systemctl stop nagios
cp -rp /usr/local/nagios /usr/local/nagios-backup
echo
echo "${txtpur}Okay, I will download Nagios Plugins latest version.${txtrst}"
sleep 2
cd upgrade-plugin 2>/dev/null;wget  --no-check-certificate https://nagios-plugins.org/download/`cat latest_plugin.txt`
count=`ls -1 nagios-plugin*.tar.gz  2>/dev/null | wc -l`
if [ $count != 0 ]
then
        sleep 2
        tar -zxvf nagios-plugins*
        cd $folder_plugin
        ./configure --with-nagios-user=nagios --with-nagios-group=nagios
        make
        make install
        systemctl start nagios
        echo
        echo "${txtpur}Okay, I will check your existing Nagios Plugins version.${txtrst}"
        sleep 1
        /usr/local/nagios/lib*/check_by_ssh -V | awk '{print $2}' | sed 's/^.//'
        sleep 2
        echo
        echo "${txtgrn}Your Nagios Plugins is updated to the latest version.${txtrst}"
        cd ..;  rm -rf index* latest_plugin.txt version.txt check_core.txt upgrade-nagios httpd.txt
        echo
        thankyou
        sleep 2
        exit
else
sleep 2;echo ${txtred}I detected there is a problem when I want to download latest Nagios Plugins version from official web.${txtrst}
sleep 2
echo ${txtylw}I will install Nagios Plugins version 2.3.3 from another source.${txtrst}
while true
do
        echo
        read -p "Are you sure want to continue (y/n)? " answer
        case $answer in
                [yY]* ) echo "${txtpur}Okay, I will install Nagios Plugins version 2.3.3${txtrst}"
                        sleep 2
                        cd upgrade-plugin 2>/dev/null;wget --no-check-certificate 'https://archive.org/download/nagios-plugins-2.3.3.tar/nagios-plugins-2.3.3.tar.gz' -O nagios-plugins-2.3.3.tar.gz
                        echo "${txtgrn}Nagios Plugin version 2.3.3 has been download and we will install it to your server${txtrst}"
                        sleep 2
                        tar -zxvf nagios-plugins-2.3.3.tar.gz
                        cd nagios-plugins-2.3.3
                        ./configure --with-nagios-user=nagios --with-nagios-group=nagios
                        make
                        make install
                        systemctl start nagios
                        echo
                        echo "${txtpur}Okay, I will check your existing Nagios Plugins version.${txtrst}"
                        sleep 1
                        /usr/local/nagios/lib*/check_by_ssh -V | awk '{print $2}' | sed 's/^.//'
                        sleep 2
                        echo
                        echo "${txtgrn}Your Nagios Plugins is version 2.3.3.${txtrst}"
                        cd ..;rm -rf index* latest_plugin.txt version.txt upgrade-nagios check_core.txt upgrade-nagios httpd.txt
                        echo
                        thankyou
                        sleep 2
                        exit
                        break;;
                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt check_core.txt upgrade-nagios targz.txt index* version.txt httpd.txt
                        break;;
                * )     echo "Just enter Y or N, please.";;
        esac
done
fi

}


check_upgrade_plugin () {
echo;echo
echo "${txtpur}Check Nagios Plugins version${txtrst}"
   wget -q --no-check-certificate https://nagios-plugins.org/download/
   cat index.html | grep plugins | grep -v sha1 | head -n 1 | sed 's/.*href=//' | sed 's/class.*//' | sed 's/\"\>.*//' | awk -F\> '{print $1}' | sed '1s/^.//' | sed '     $ s/.$//' > latest_plugin.txt
   latest_plugin=`cat latest_plugin.txt | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`
   existing_plugin=`/usr/local/nagios/lib*/check_ssh -V | awk '{print $2}' | sed 's/^.//'`
   folder_plugin=`cat latest_plugin.txt | sed -e 's/.tar.gz//g'` 2> /dev/null

   echo
   echo "${txtylw}I will check exist plugin nagios version in your server. Please wait a minute ...${txtrst}";sleep 2
   echo "${txtcyn}Your Nagios Plugins version is $existing_plugin"${txtrst}
   echo;sleep 2
   echo "${txtylw}I will check latest plugin nagios version. Please wait a minute ...${txtrst}";sleep 2
   echo "${txtcyn}Latest Nagios Plugins version is $latest_plugin ${txtrst}";sleep 2
   echo

                if [ $existing_plugin = $latest_plugin ]
                then
                         echo "${txtgrn}Your existing Nagios Plugins version is up-to-date.${txtrst}"
                         rm -rf index* version.txt latest_plugin.txt check_latest_core.txt check_core.txt upgrade-nagios httpd.txt
                         echo
                         thankyou
                         sleep 3
                else
                        while true
                        do
                        read -p "${txtylw}Are you sure want to update your Nagios Plugins (y/n)?${txtrst} " answer
                        echo
                        case $answer in
                                [yY]* ) sleep 1;echo
                                        upgrade_plugin
                                        break;;
                                [nN]* ) sleep 1
                                        rm -rf index* latest_plugin.txt version.txt check_latest_core.txt check_core.txt upgrade-nagios httpd.txt
                                        echo
                                        thankyou
                                        sleep 2
                                        exit
                                        break;;
                                * )     echo "Just enter Y or N, please.";;
                                esac
                        done
                fi
}





upgrade_nagios_suse() {

echo "${txtpur}Check Nagios Core Version${txtrst}"

core_existing_version=`/usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//`


echo
echo "${txtylw}I will check existing nagios version in your server. Please wait a minute ...${txtrst}";sleep 2
sleep 2
echo "${txtcyn}Your Nagios version is $core_existing_version"${txtrst}
echo;sleep 2


mkdir upgrade-nagios 2> /dev/null;wget --no-check-certificate -q https://www.nagios.org/downloads/nagios-core/thanks/?t=1504034794 2> /dev/null

latest_nagios=`cat index.html* 2>/dev/null  | grep "assets.nagios.com/downloads/nagioscore/releases" | sed -n '1p' | awk '{print $6}' | sed -e 's/<[^()]*>//g' | sed -e 's/\/[^()]*\///g' | sed -e 's/\"[^()]*\">//g' | sed -e 's/href=//g' `
version=`echo $latest_nagios | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

echo $latest_nagios | grep tar.gz > check_core.txt
core=`ls -al | grep check_core.txt | awk '{print $5}'`


if [ $core -eq 0 ]
then
         sleep 2
         echo ${txtred}I am sorry, I can not check the latest version from the official web because there is a problem.${txtrst}
         sleep 2
         echo
         echo ${txtylw}I will install Nagios Core version 4.4.6 from another source.${txtrst}
         while true
         do
                         sleep 2
                         echo
                         read -p "Are you sure want to continue (y/n)? " answer
                         case $answer in
                         [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Core version 4.4.6${txtrst}"
                                 sleep 2
                                 echo "${txtylw}Downloading Nagios Core version 4.4.6 ... ${txtrst}"
                                 cd upgrade-nagios;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                 echo "${txtgrn}Nagios Core version 4.4.6 has been download and we will install it to your server${txtrst}"
                                 tar -zxvf nagios-4.4.6.tar.gz
                                 cd nagios-4.4.6
                                 ./configure --with-httpd-conf=/etc/apache2/vhosts.d
                                 make all
                                 make install
                                 make install-daemoninit
                                 systemctl start nagios
                                 echo
                                 echo "${txtpur}Checking Nagios Core version ${txtrst}"
                                 sleep 2
                                 /usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//
                                 echo
                                 echo "${txtylw}Your Nagios Core version is 4.4.6${txtrst}"
                                 echo
                                 sleep 2
                                 echo
                                 check_upgrade_plugin
                                 echo
                                 sleep 2
                                 thankyou
                                 sleep 2
                                 sleep 2;cd ..;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt targz.txt httpd.txt
                                 exit
                                 break;;
                         [nN]* ) sleep 2;echo;check_upgrade_plugin;
                                 exit
                                 echo
                                 break;;
                         * ) echo "Just enter Y or N, please.";;
                        esac
        done
fi





count=`ls -1 index.html* 2>/dev/null | wc -l `
if [ $count != 0 ]
then
        echo "${txtcyn}Latest version of Nagios core is $version${txtrst}" > version.txt
        sleep 1
fi

core_update_version=`cat version.txt | awk '{print $7}' | tr -dc '0-9'  | sed 's/.\{1\}/&./g' |  sed s/.$//`

echo;sleep 2
echo "${txtylw}I will check latest nagios version. Please wait a minute ...${txtgrn}";sleep 2
echo "${txtcyn}Latest Nagios version is $core_update_version${txtrst}";sleep 2
echo

core_existing=`/usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9'`
core_update=`cat version.txt | awk '{print $7}' | tr -dc '0-9'`

if [ $core_existing -ge $core_update ]
then
   echo "${txtgrn}Your existing Nagios version is up-to-date.${txtrst}"
   echo
   sleep 2
   check_upgrade_plugin
else
    echo "${txtred}Your existing Nagios version is not update.${txtrst}"
    read -p "${txtylw}Are you sure want to update (y/n)${txtrst}? " answer
        echo
                case $answer in
                [yY]* ) sleep 2;echo;echo "${txtpur}Okay, I will upgrade your nagios version to the latest version.${txtrst}"
                        echo "${txtpur}I will backup your nagios to /usr/local/nagios-backup.${txtrst}"
                        sleep 2
                        systemctl stop nagios
                        cp -rp /usr/local/nagios /usr/local/nagios-backup
                        echo
                        echo "${txtpur}Okay, I will download Nagios Core latest version.${txtrst}"
                        sleep 2
                        echo $latest_nagios | grep tar.gz > check_latest_core.txt
                        folder_plugin=`echo $latest_nagios | sed -e 's/.tar.gz//g'` 2> /dev/null
                        count=`ls -al check_latest_core.txt | awk '{print $5}'`
                        if [ $count != 0 ]
                        then
                                sleep 2
                                sleep 2
                                mkdir upgrade-nagios 2> /dev/null;cd upgrade-nagios;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/`echo $latest_nagios`
                                sleep 2
                                count=`ls -1 nagios-*.tar.gz  2>/dev/null | wc -l`
                                if [ $count != 0 ]
                                then
                                        sleep 2
                                        tar -zxvf nagios-*
                                        cd $folder_plugin
                                        ./configure --with-httpd-conf=/etc/apache2/vhosts.d
                                        make all
                                        make install
                                        make install-daemoninit
                                        systemctl start nagios
                                        echo
                                        echo "${txtpur}Okay, I will check your existing Nagios Core version.${txtrst}"
                                        sleep 1
                                        /usr/local/nagios/bin/nagios -V | head -n 2 | sed '/^$/d'
                                        sleep 2
                                        echo
                                        echo "${txtgrn}Your Nagios Core is updated to the latest version.${txtrst}"
                                        cd ..;rm -rf index* latest_plugin.txt version.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt wget-log* httpd.txt
                                        echo
                                        check_upgrade_plugin
                                        sleep 2
                                        echo
                                        thankyou
                                        sleep 2
                                        exit
                                else
                                        sleep 2;echo ${txtred}I detected there is a problem when I want to download latest Nagios Plugins version from official web.${txtrst}
                                        sleep 2
                                        echo ${txtylw}I will install Nagios Core version 4.4.6 from another source.${txtrst}
                                        while true
                                        do
                                                 echo
                                                 read -p "Are you sure want to continue (y/n)? " answer
                                                 case $answer in
                                                        [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Core version 4.4.6${txtrst}"
                                                                sleep 2
                                                                echo "${txtylw}Downloading Nagios Core version 4.4.6 ... ${txtrst}"
                                                                cd upgrade-plugin;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                                                echo "${txtgrn}Nagios Core version 4.4.6 has been download and we will install it to your server${txtrst}"
                                                                tar -zxvf nagios-4.4.6.tar.gz
                                                                cd nagios-4.4.6
                                                                ./configure --with-httpd-conf=/etc/apache2/vhosts.d
                                                                make all
                                                                make install
                                                                make install-daemoninit
                                                                systemctl start nagios
                                                                echo
                                                                echo "${txtylw}Checking Nagios Core version ${txtrst}"
                                                                sleep 2
                                                                /usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//
                                                                echo
                                                                echo "${txtpur}Your Nagios Core version is 4.4.6${txtrst}"
                                                                echo
                                                                sleep 2
                                                                echo
                                                                check_upgrade_plugin
                                                                echo
                                                                sleep 2
                                                                thankyou
                                                                sleep 2
                                                                sleep 2;cd ..;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt targz.txt wget-log* httpd.txt
                                                                exit
                                                                break;;
                                                        [nN]* ) sleep 2;check_upgrade_plugin;
                                                                break;;
                                                        * ) echo "Just enter Y or N, please.";;
                                                 esac
                                        done
                                fi
                        fi
                        break;;
                [nN]* ) sleep 2;check_upgrade_plugin;
                        break;;
                    * ) echo "Just enter Y or N, please.";;
                esac

fi

}












upgrade_nagios_ubuntu() {

echo;echo
echo "${txtpur}Check Nagios Core Version${txtrst}"

core_existing_version=`/usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//`


echo
echo "${txtylw}I will check existing nagios version in your server. Please wait a minute ...${txtrst}";sleep 2
sleep 2
echo "${txtcyn}Your Nagios version is $core_existing_version"${txtrst}
echo;sleep 2


mkdir upgrade-nagios 2> /dev/null;wget --no-check-certificate -q https://www.nagios.org/downloads/nagios-core/thanks/?t=1504034794 2> /dev/null

latest_nagios=`cat index.html* 2>/dev/null  | grep "assets.nagios.com/downloads/nagioscore/releases" | sed -n '1p' | awk '{print $2}' | sed -e 's/<[^()]*>//g' | sed -e 's/\/[^()]*\///g' | sed -e 's/\"[^()]*\">//g' | sed -e 's/href=//g' `
version=`echo $latest_nagios | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`

echo $latest_nagios | grep tar.gz > check_core.txt
core=`ls -al | grep check_core.txt | awk '{print $5}'`


if [ $core -eq 0 ]
then
         sleep 2
         echo ${txtred}I am sorry, I can not check the latest version from the official web because there is a problem.${txtrst}
         sleep 2
         echo
         echo ${txtylw}I will install Nagios Core version 4.4.6 from another source.${txtrst}
         while true
         do
                         sleep 2
                         echo
                         read -p "Are you sure want to continue (y/n)? " answer
                         case $answer in
                         [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Core version 4.4.6${txtrst}"
                         sleep 2
                         echo "${txtylw}Downloading Nagios Core version 4.4.6 ... ${txtrst}"
                         cd upgrade-nagios;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                         echo "${txtgrn}Nagios Core version 4.4.6 has been download and we will install it to your server${txtrst}"
                         sleep 1
                         echo
                         tar -zxvf nagios-4.4.6.tar.gz
                         cd nagios-4.4.6
                         ./configure --with-httpd-conf=/etc/apache2/sites-enabled
                         make all
                         make install
                         make install-daemoninit
                         systemctl start nagios
                         echo
                         echo "${txtpur}Checking Nagios Core version ${txtrst}"
                         sleep 2
                         /usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//
                         echo
                         echo
                         echo "${txtpur}Your Nagios Core version is 4.4.6${txtrst}"
                         echo
                         sleep 2
                         echo
                         check_upgrade_plugin
                         echo
                         sleep 2
                         thankyou
                         sleep 2
                         sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt targz.txt wget-log* httpd.txt
                         exit
                         break;;
                         [nN]* ) sleep 2;echo;check_upgrade_plugin;
                         exit
                         echo
                         break;;
                         * ) echo "Just enter Y or N, please.";;
                        esac
        done
fi





count=`ls -1 index.html* 2>/dev/null | wc -l `
if [ $count != 0 ]
then
        echo "${txtcyn}Latest version of Nagios core is $version${txtrst}" > version.txt
        sleep 1
fi

core_update_version=`cat version.txt | awk '{print $7}' | tr -dc '0-9'  | sed 's/.\{1\}/&./g' |  sed s/.$//`

echo;sleep 2
echo "${txtylw}I will check latest nagios version. Please wait a minute ...${txtgrn}";sleep 2
echo "${txtcyn}Latest Nagios version is $core_update_version${txtrst}";sleep 2
echo

core_existing=`/usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9'`
core_update=`cat version.txt | awk '{print $7}' | tr -dc '0-9'`

if [ $core_existing -ge $core_update ]
then
   echo "${txtgrn}Your existing Nagios version is up-to-date.${txtrst}"
   echo
   sleep 2
   check_upgrade_plugin
else
    echo "${txtred}Your existing Nagios version is not update.${txtrst}"
    read -p "${txtylw}Are you sure want to update (y/n)${txtrst}? " answer
        echo
                case $answer in
                [yY]* ) sleep 2;echo;echo "${txtpur}Okay, I will upgrade your nagios version to the latest version.${txtrst}"
                        echo "${txtpur}I will backup your nagios to /usr/local/nagios-backup.${txtrst}"
                        sleep 2
                        systemctl stop nagios
                        cp -rp /usr/local/nagios /usr/local/nagios-backup
                        echo
                        echo "${txtpur}Okay, I will download Nagios Core latest version.${txtrst}"
                        sleep 2
                        echo $latest_nagios | grep tar.gz > check_latest_core.txt
                        folder_plugin=`echo $latest_nagios | sed -e 's/.tar.gz//g'` 2> /dev/null
                        count=`ls -al check_latest_core.txt | awk '{print $5}'`
                        if [ $count != 0 ]
                        then
                                sleep 2
                                echo
                                mkdir upgrade-nagios 2> /dev/null;cd upgrade-nagios;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/`echo $latest_nagios`
                                sleep 2
                                count=`ls -1 nagios-*.tar.gz  2>/dev/null | wc -l`
                                if [ $count != 0 ]
                                then
                                    sleep 2
                                    tar -zxvf nagios-*
                                    cd $folder_plugin
                                    ./configure --with-httpd-conf=/etc/apache2/sites-enabled
                                    make all
                                    make install
                                    make install-daemoninit
                                    systemctl start nagios
                                    echo
                                    echo "${txtpur}Okay, I will check your existing Nagios Core version.${txtrst}"
                                    sleep 1
                                    /usr/local/nagios/bin/nagios -V | head -n 2
                                    sleep 2
                                    echo
                                    echo "${txtgrn}Your Nagios Core is updated to the latest version.${txtrst}"
                                    rm -rf index* latest_plugin.txt version.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt wget-log* httpd.txt
                                    echo
                                    check_upgrade_plugin
                                    sleep 2
                                    echo
                                    thankyou
                                    sleep 2
                                    exit
                                else
                                    sleep 2;echo ${txtred}I detected there is a problem when I want to download latest Nagios Plugins version from official web.${txtrst}
                                    sleep 2
                                    echo ${txtylw}I will install Nagios Core version 4.4.6 from another source.${txtrst}
                                    while true
                                    do
                                            echo
                                            read -p "Are you sure want to continue (y/n)? " answer
                                            case $answer in
                                                [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Core version 4.4.6${txtrst}"
                                                        sleep 2
                                                        echo "${txtylw}Downloading Nagios Core version 4.4.6 ... ${txtrst}"
                                                        cd upgrade-nagios;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                                        echo "${txtgrn}Nagios Core version 4.4.6 has been download and we will install it to your server${txtrst}"
                                                        sleep 1
                                                        echo
                                                        tar -zxvf nagios-4.4.6.tar.gz
                                                        cd nagios-4.4.6
                                                        ./configure --with-httpd-conf=/etc/apache2/sites-enabled
                                                        make all
                                                        make install
                                                        make install-daemoninit
                                                        systemctl start nagios
                                                        echo
                                                        echo "${txtylw}Checking Nagios Core version ${txtrst}"
                                                        sleep 2
                                                        /usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//
                                                        echo
                                                        echo "${txtpur}Your Nagios Core version is 4.4.6${txtrst}"
                                                        echo
                                                        sleep 2
                                                        echo
                                                        check_upgrade_plugin
                                                        echo
                                                        sleep 2
                                                        thankyou
                                                        sleep 2
                                                        sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt targz.txt wget-log* httpd.txt
                                                        exit
                                                        break;;
                                                [nN]* ) sleep 2;echo;:check_upgrade_plugin;
                                                        break;;
                                                * ) echo "Just enter Y or N, please.";;
                                            esac
                                    done
                                fi
                        fi
                        break;;
                [nN]* ) sleep 2;check_upgrade_plugin
                        break;;
                    * ) echo "Just enter Y or N, please.";;
                esac

fi

}





upgrade_nagios_centos() {

echo "${txtpur}Check Nagios Core Version${txtrst}"

core_existing_version=`/usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//`


echo
echo "${txtylw}I will check existing nagios version in your server. Please wait a minute ...${txtrst}";sleep 2
sleep 2
echo "${txtcyn}Your Nagios version is $core_existing_version"${txtrst}
echo;sleep 2


mkdir upgrade-nagios 2> /dev/null;wget --no-check-certificate -q https://www.nagios.org/downloads/nagios-core/thanks/?t=1504034794 2> /dev/null

latest_nagios=`cat index.html* 2>/dev/null  | grep "assets.nagios.com/downloads/nagioscore/releases" | sed -n '1p' | awk '{print $6}' | sed -e 's/<[^()]*>//g' | sed -e 's/\/[^()]*\///g' | sed -e 's/\"[^()]*\">//g' | sed -e 's/href=//g' `
version=`echo $latest_nagios | sed 's/.*-//' | sed 's/t.*//' | sed 's/.$//'`
folder_plugin=`echo $latest_nagios | sed -e 's/.tar.gz//g'` 2> /dev/null
echo $latest_nagios | grep tar.gz > check_core.txt
core=`ls -al | grep check_core.txt | awk '{print $5}'`


if [ $core -eq 0 ]
then
         sleep 2
         echo ${txtred}I am sorry, I can not check the latest version from the official web because there is a problem.${txtrst}
         sleep 2
         echo
         echo ${txtylw}I will install Nagios Core version 4.4.6 from another source.${txtrst}
         while true
         do
                         sleep 2
                         echo
                         read -p "Are you sure want to continue (y/n)?" answer
                         case $answer in
                         [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Core version 4.4.6${txtrst}"
                                 sleep 2
                                 echo "${txtylw}Downloading Nagios Core version 4.4.6 ... ${txtrst}"
                                 cd upgrade-plugin 2>/dev/null;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                 echo "${txtgrn}Nagios Core version 4.4.6 has been download and we will install it to your server${txtrst}"
                                 echo
                                 tar -zxvf nagios-4.4.6.tar.gz
                                 cd nagios-4.4.6
                                 ./configure
                                 make all
                                 make install
                                 make install-daemoninit
                                 systemctl start nagios 2>/dev/null
                                 service nagios start 2>/dev/null
                                 echo
                                 echo "${txtpur}Checking Nagios Core version ${txtrst}"
                                 sleep 2
                                 /usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//
                                 echo
                                 echo "${txtylw}Your Nagios Core version is 4.4.6${txtrst}"
                                 echo
                                 sleep 2
                                 echo
                                 check_upgrade_plugin
                                 echo
                                 sleep 2
                                 thankyou
                                 sleep 2
                                 sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt targz.txt wget-log* version.txt index* httpd.txt
                                 exit
                                 break;;
                         [nN]* ) sleep 2;echo;check_upgrade_plugin;
                                 exit
                                 echo
                                 break;;
                         * ) echo "Just enter Y or N, please.";;
                        esac
        done
fi





count=`ls -1 index.html* 2>/dev/null | wc -l `
if [ $count != 0 ]
then
        echo "${txtcyn}Latest version of Nagios core is $version${txtrst}" > version.txt
        sleep 1
fi

core_update_version=`cat version.txt | awk '{print $7}' | tr -dc '0-9'  | sed 's/.\{1\}/&./g' |  sed s/.$//`

echo;sleep 2
echo "${txtylw}I will check latest nagios version. Please wait a minute ...${txtgrn}";sleep 2
echo "${txtcyn}Latest Nagios version is $core_update_version${txtrst}";sleep 2
echo

core_existing=`/usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9'`
core_update=`cat version.txt | awk '{print $7}' | tr -dc '0-9'`

if [ $core_existing -ge $core_update ]
then
   echo "${txtgrn}Your existing Nagios version is up-to-date.${txtrst}"
   echo
   sleep 2
   check_upgrade_plugin
else
    echo "${txtred}Your existing Nagios version is not update.${txtrst}"
    read -p "${txtylw}Are you sure want to update (y/n)${txtrst}? " answer
        echo
                case $answer in
                [yY]* ) sleep 2;echo;echo "${txtpur}Okay, I will upgrade your nagios version to the latest version.${txtrst}"
                        echo "${txtpur}I will backup your nagios to /usr/local/nagios-backup.${txtrst}"
                        sleep 2
                        systemctl stop nagios 2>/dev/null
                        service nagios stop 2>/dev/null
                        cp -rp /usr/local/nagios /usr/local/nagios-backup
                        echo
                        echo "${txtpur}Okay, I will download Nagios Core latest version.${txtrst}"
                        sleep 2
                        echo $latest_nagios | grep tar.gz > check_latest_core.txt
                        folder_plugin=`echo $latest_nagios | sed -e 's/.tar.gz//g'` 2> /dev/null
                        count=`ls -al check_latest_core.txt | awk '{print $5}'`
                        if [ $count != 0 ]
                        then
                                sleep 2
                                sleep 2
                                mkdir upgrade-nagios 2> /dev/null;cd upgrade-nagios;wget  --no-check-certificate https://assets.nagios.com/downloads/nagioscore/releases/`echo $latest_nagios`
                                sleep 2
                                count=`ls -1 nagios-*.tar.gz  2>/dev/null | wc -l`
                                if [ $count != 0 ]
                                then
                                    sleep 2
                                    tar -zxvf nagios-*
                                    cd $folder_plugin
                                    ./configure
                                    make all
                                    make install
                                    make install-daemoninit
                                    systemctl start nagios 2>/dev/null
                                    service nagios start 2>/dev/null
                                    echo
                                    echo "${txtpur}Okay, I will check your existing Nagios Core version.${txtrst}"
                                    sleep 1
                                    /usr/local/nagios/bin/nagios -V | head -n 2
                                    sleep 2
                                    echo
                                    echo "${txtgrn}Your Nagios Core is updated to the latest version.${txtrst}"
                                    rm -rf index* latest_plugin.txt version.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt wget-log* version.txt httpd.txt
                                    echo
                                    check_upgrade_plugin
                                    sleep 2
                                    echo
                                    thankyou
                                    sleep 2
                                    exit
                                else
                                    sleep 2;echo ${txtred}I detected there is a problem when I want to download latest Nagios Plugins version from official web.${txtrst}
                                    sleep 2
                                    echo ${txtylw}I will install Nagios Core version 4.4.6 from another source.${txtrst}
                                    while true
                                    do
                                         echo
                                         read -p "Are you sure want to continue (y/n)? " answer
                                         case $answer in
                                             [yY]* ) echo;echo "${txtpur}Okay, I will download Nagios Core version 4.4.6${txtrst}"
                                                     sleep 2
                                                     echo "${txtylw}Downloading Nagios Core version 4.4.6 ... ${txtrst}"
                                                     cd upgrade-nagios;wget --no-check-certificate 'https://archive.org/download/nagios-4.4.6.tar/nagios-4.4.6.tar.gz' -O nagios-4.4.6.tar.gz
                                                     echo "${txtgrn}Nagios Core version 4.4.6 has been download and we will install it to your server${txtrst}"
                                                     sleep 2
                                                     echo
                                                     tar -zxvf nagios-4.4.6.tar.gz
                                                     cd nagios-4.4.6
                                                     ./configure
                                                     make all
                                                     make install
                                                     make install-daemoninit
                                                     systemctl start nagios 2>/dev/null
                                                     service nagios start 2>/dev/null
                                                     echo
                                                     echo "${txtylw}Checking Nagios Core version ${txtrst}"
                                                     sleep 2
                                                     /usr/local/nagios/bin/nagios --help | grep Core | head -n 1 | tr -dc '0-9' | sed 's/.\{1\}/&./g' |  sed s/.$//
                                                     echo
                                                     echo "${txtpur}Your Nagios Core version is 4.4.6${txtrst}"
                                                     echo
                                                     sleep 2
                                                     echo
                                                     check_upgrade_plugin
                                                     echo
                                                     sleep 2
                                                     thankyou
                                                     sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt rpm_nagios.txt upgrade-nagios check_latest_core.txt latest_core.txt check_latest_core.txt check_core.txt targz.txt wget-log* httpd.txt
                                                     exit
                                                     break;;
                                             [nN]* ) sleep 2;echo;check_upgrade_plugin;
                                                     break;;
                                                 * ) echo "Just enter Y or N, please.";;
                                         esac
                                    done
                                fi
                        fi
                        break;;
                [nN]* ) sleep 2;check_upgrade_plugin;
                        break;;
                    * ) echo "Just enter Y or N, please.";;
                esac

fi

}

check_os_upgrade () {
############ Checking OS  ################
echo "${txtylw}Try to guess your operating system "
sleep 2
if [ -f /etc/debian_version ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep ^NAME | awk 'NR > 1 {print $1}' RS='"' FS='"'` `cat /etc/debian_version`${txtrst}"
sleep 2
echo
upgrade_nagios_ubuntu
echo
else

if [ -f /etc/redhat-release ]
then
echo "${txtgrn}Your Operating System is `cat /etc/redhat-release`${txtrst}"
sleep 2
echo
upgrade_nagios_centos
else

if [ -f /etc/SUSE-brand ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep PRETTY_NAME | sed 's/.*=//' | sed 's/^.//' | sed 's/.$//'`${txtrst}"
echo
sleep 2
upgrade_nagios_suse
echo
else

echo "${txtred}I think your OS is not Debian/Ubuntu or RedHat-Based (CentOS, AlmaLinux, RockyLinux, Fedora) or openSUSE${txtrst}"
echo "${txtred}I am sorry, only work on Linux Debian/Ubuntu, RedHat-Based (CentOS, AlmaLinux, RockyLinux, Fedora), and openSUSE${txtrst}"
echo "${txtred}So, I can not install Nagios in your server${txtrst}"
stop
fi
fi
fi
}





upgrade_nagios() {
############ Checking Nagios  ################
echo "${txtbld}I will continue your request if you have installed Nagios from the source code${txtrst}"
echo "${txtbld}using default folder (/usr/local/nagios) in this server.${txtrst}"
sleep 2;echo;
echo "${txtylw}I will check whether Nagios application exist or not. ${txtrst}"
echo "${txtylw}Please wait a minute... ${txtrst}"
sleep 2
if [ -d "/usr/local/nagios/" ]
then
        echo "${txtgrn}It looks like you have installed Nagios yet. ${txtrst}"
        sleep 2
        echo
        check_user
        check_internet
        check_os_upgrade
else
        sleep 2
        echo "${txtred}It looks like you have not installed Nagios yet or you installed Nagios not from source but using Yum. ${txtrst}"
        echo "${txtred}Please install Nagios using source first. ${txtrst}"
        echo "${txtred}You have not installed Nagios${txtrst}" 2> /dev/null  > $log
fi
}





###################################################################################################
#  _____           _        _ _     _   _ _____  _____  ______     _   _             _            #
# |_   _|         | |      | | |   | \ | |  __ \|  __ \|  ____|   | \ | |           (_)           #
#   | |  _ __  ___| |_ __ _| | |   |  \| | |__) | |__) | |__      |  \| | __ _  __ _ _  ___  ___  #
#   | | | '_ \/ __| __/ _` | | |   | . ` |  _  /|  ___/|  __|     | . ` |/ _` |/ _` | |/ _ \/ __| #
#  _| |_| | | \__ \ || (_| | | |   | |\  | | \ \| |    | |____    | |\  | (_| | (_| | | (_) \__ \ #
# |_____|_| |_|___/\__\__,_|_|_|   |_| \_|_|  \_\_|    |______|   |_| \_|\__,_|\__, |_|\___/|___/ #
#                                                                               __/ |             #
#                                                                              |___/              #
#                                                                                                 #
###################################################################################################


install_nrpe_agent_centos() {
echo "${txtylw}Compiling NRPE${txtrst}"
sleep 2
./configure --enable-command-args;check;echo;sleep 1;make all;echo;sleep 1;check;make install-groups-users;sleep 1;echo;check;make install;check;echo;sleep 1;make install-config;check;echo;sleep 1;make install-init;check;echo;sleep 1;echo >> /etc/services;echo '# Nagios services' >> /etc/services;echo 'nrpe 5666/tcp' >> /etc/services;make install-init;check;sleep 1;
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
echo "Compile NRPE successfully" 2> /dev/null  >> $log
echo
echo "${txtylw}I will turn on NRPE service${txtrst}"
sleep 2
systemctl enable nrpe.service 2>/dev/null
systemctl start nrpe.service 2>/dev/null;sleep 2
start nrpe 2>/dev/null;sleep 2
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "${txtgrn}NRPE plugin has been installed in your server.${txtrst}"
sleep 2
echo
echo "${txtylw}I will test NRPE service and please make sure there is no error when I test it${txtrst}"
sleep 2
echo
echo
echo "${txtblu}/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1
sleep 2
echo
echo "${txtblu}/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_load${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_load
sleep 2
echo
echo "${txtblu}/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_total_procs${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_total_procs
sleep 2
echo
echo "${txtgrn}NRPE plugin has been installed${txtrst}"
sleep 2
echo;echo
echo "${txtylw}If you want your server to be monitored by the Nagios server, add IP address of Nagios server${txtrst}"
echo "${txtylw}add IP address of Nagios server to the file /usr/local/nagios/etc/nrpe.cfg${txtrst}"
echo "${txtylw}in the allowed_hosts section then restart nrpe with command:${txtrst}"
echo "${txtblu}systemctl restart nrpe ${txtrst}(On CentOS8&7, AlmaLinux, RockyLinux, Ubuntu/Debian, and OpenSUSE)"
echo "${txtblu}restart nrpe${txtrst}(On centOS 6)"
sleep 7
thankyou
}

download_nrpe_plugin() {
cd $path;echo "${txtylw}I will install NRPE Plugin${txtrst}"
        echo
        sleep 2
        echo "${txtylw}Search latest version of NRPE Plugin${txtrst}"
        echo "${txtylw}Please wait a minute...${txtrst}"
        sleep 2
        echo
        echo "${txtylw}Download latest version of NRPE plugin ...${txtrst}";sleep 2;
        wget --no-check-certificate https://github.com/NagiosEnterprises/nrpe/archive/master.zip
        count=`ls -1 master.zip 2>/dev/null | wc -l `
               if [ $count != 0 ]
                   then
                        echo "${txtgrn}Done${txtrst}"
                        echo
                        sleep 2
                        echo "${txtylw}Extract package NRPE${txtrst}"
                        sleep 2
                        unzip master.zip
                        check
                        echo "${txtgrn}Done${txtrst}"
                        sleep 2
                        cd nrpe-master;
                        echo
                        sleep 2
                        install_nrpe_agent_centos
                else
                        echo ${txtred}I detected there is a problem when I want to download latest NRPE from official web.${txtrst}
                        sleep 2
                        echo ${txtylw}I will install NRPE version 4.0.3 from another source.${txtrst}
                                while true
                                do
                                echo
                                read -p "Are you sure want to continue (y/n)? " answer
                                case $answer in
                                [yY]* ) sleep 1;echo "${txtpur}Okay, I will download NRPE version 4.0.3${txtrst}"
                                        sleep 2
                                        echo
                                        echo "${txtylw}Downloading NRPE plugin version 4.0.3 ...${txtrst}";sleep 2;
                                        cd $path;wget --no-check-certificate 'https://archive.org/download/nrpe-4.0.3.tar/nrpe-4.0.3.tar.gz' -O nrpe-4.0.3.tar.gz
                                        echo "${txtgrn}NRPE version 4.0.3 has been download and we will install it to your server${txtrst}"
                                        sleep 1
                                        echo "${txtgrn}Done${txtrst}"
                                        echo
                                        echo "${txtylw}Extract package NRPE${txtrst}"
                                        sleep 2
                                        tar -zxvf nrpe-4.0.3.tar.gz
                                        check
                                        echo "${txtgrn}Done${txtrst}"
                                        sleep 2
                                        cd nrpe-4.0.3
                                        echo
                                        sleep 2
                                        install_nrpe_agent_centos
                                break;;
                                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                                        thankyou
                                break;;
                         * )     echo "Just enter Y or N, please.";;
                         esac
                         done
        fi
}

nrpe_agent_centos() {
echo
echo "${txtylw}I will install Nagios Plugin first.${txtrst}"
echo "${txtylw}Installation Some Packages Needed to Install Nagios plugin.${txtrst}"
sleep 2
if [ -f /etc/redhat-release ]
then
        yum install -y gcc glibc glibc-common openssl openssl-devel perl make gettext automake wget net-snmp net-snmp-utils epel-release perl-Net-SNMP
elif [ -f /etc/debian_version ]
then
        apt-get install -y autoconf unzip automake make openssl gcc libc6 libmcrypt-dev libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
elif [ -f /etc/SUSE-brand ]
then
        zypper --non-interactive install autoconf gcc glibc libtomcrypt-devel make libopenssl-devel wget gettext gettext-runtime automake net-snmp perl-Net-SNMP
else
        echo "${txtred}I think your OS is not Debian/Ubuntu or Centos or openSUSE${txtrst}"
        echo "${txtred}I am sorry, only work on Linux Debian/Ubuntu, RedHat-Based (CentOS, AlmaLinux, RockyLinux, Fedora), and openSUSE${txtrst}"
        echo "${txtred}So, I can not install NRPE in your server${txtrst}"
        sleep 3
        exit
fi
sleep 2
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "${txtylw}I will download Nagios Plugin${txtrst}"
wget --no-check-certificate https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
sleep 2
echo "${txtgrn}Done${txtrst}"
echo
count=`ls -1 nagios-plugin*.tar.gz  2>/dev/null | wc -l`
if [ $count != 0 ]
then
        sleep 2
        echo;echo "${txtgrn}Extract Nagios Plugin${txtrst}";sleep 2;echo
        tar -zxvf nagios-plugins-2.3.3.tar.gz;check;sleep 2;echo "${txtgrn}Done${txtrst}"
        cd nagios-plugins-2.3.3;sleep 2;echo;echo;./configure;check;echo;sleep 1;make;check;echo;sleep 1;make install;check;echo;sleep 1;
        sleep 2;echo;echo "${txtgrn}Done${txtrst}";echo
        download_nrpe_plugin

else


        echo ${txtred}I detected there is a problem when I want to download Nagios Plugins version from official web.${txtrst}
        sleep 2
        echo ${txtylw}I will install Nagios Plugins version 2.3.3 from another source${txtrst}

        while true
        do
        echo
        read -p "Are you sure want to continue (y/n)? " answer
        case $answer in
                [yY]* ) echo "${txtpur}Okay, I will install Nagios Plugins version 2.3.3.${txtrst}"
                        sleep 2
                        echo
                        echo "${txtylw}Downloading Nagios Plugins...${txtrst}";sleep 2;echo
                        cd $path;wget --no-check-certificate 'https://archive.org/download/nagios-plugins-2.3.3.tar/nagios-plugins-2.3.3.tar.gz' -O nagios-plugins-2.3.3.tar.gz
                        echo "${txtgrn}Nagios Plugin version 2.3.3 has been download and we will install it to your server${txtrst}"
                        sleep 2
                        tar -zxvf nagios-plugins-2.3.3.tar.gz;check;sleep 2;echo "${txtgrn}Done${txtrst}"
                        cd nagios-plugins-2.3.3;sleep 2;echo;echo;./configure;check;echo;sleep 1;make;check;echo;sleep 1;make install;check;echo;sleep 1;
                        sleep 2;echo;echo "${txtgrn}Done${txtrst}";echo
                        download_nrpe_plugin

                break;;

                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                        thankyou
                        break;;
                * )     echo "Just enter Y or N, please.";;
        esac
        done

fi
}



nrpe_403_centos() {
echo
echo "${txtylw}Extract package NRPE${txtrst}"
sleep 2
tar -zxvf nrpe-4.0.3.tar.gz
check
sleep 2
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "Extract package NRPE successfully" 2> /dev/null  >> $log
echo
echo "${txtylw}Compiling NRPE${txtrst}"
sleep 2
cd nrpe-4.0.3;./configure;check;echo;sleep 1;make all;check;echo;sleep 1;make install-daemon;check;echo;sleep 1;
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
echo "Compile NRPE successfully" 2> /dev/null  >> $log
echo
echo "${txtylw}Testing NRPE${txtrst}"
sleep 2
echo
echo "${txtylw}/usr/local/nagios/lib*/check_nrpe -V${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -V
sleep 2
echo
echo "${txtylw}/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_users${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_users
sleep 2
echo
echo "${txtgrn}NRPE plugin has been installed and running normally in your server${txtrst}"
sleep 2
echo
thankyou

}



nrpe_server_centos() {
echo "${txtylw}Extract package NRPE${txtrst}"
sleep 2
unzip master.zip
check
sleep 2
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "Extract package NRPE successfully" 2> /dev/null  >> $log
echo;echo
echo "${txtylw}Compiling NRPE${txtrst}"
sleep 2
cd nrpe-master;./configure;check;echo;sleep 1;make all;check;echo;sleep 1;check;make install-groups-users;check;echo;sleep 1;make install;check;sleep 1;echo;make install-config;check;echo;sleep 1;make install-init;check;sleep 1;echo;
echo "${txtgrn}Done${txtrst}"
echo
echo "${txtylw}Update the service${txtrst}"
sleep 2
echo >> /etc/services;check;echo '# Nagios services' >> /etc/services;check;echo 'nrpe    5666/tcp' >> /etc/services;check;sh -c "echo >> /etc/services";check;sh -c "sudo echo '# Nagios services' >> /etc/services";check;sh -c "sudo echo 'nrpe    5666/tcp' >> /etc/services"
echo "${txtgrn}Done${txtrst}"
echo
sleep 2
echo "Compile NRPE successfully" 2> /dev/null  >> $log
echo "${txtylw}Start NRPE Service${txtrst}"
systemctl enable nrpe.service 2>/dev/null
systemctl start nrpe.service 2>/dev/null;sleep 2
start nrpe 2>/dev/null;sleep 2
sleep 2
echo "${txtgrn}Done${txtrst}"
echo
echo "${txtpur}Test NRPE Plugin${txtrst}"
sleep 2
echo
echo "${txtylw}/usr/local/nagios/lib*/check_nrpe -V${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -V
sleep 2
echo
echo "${txtylw}/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_users${txtrst}"
sleep 2
/usr/local/nagios/lib*/check_nrpe -H 127.0.0.1 -c check_users
sleep 2
echo
echo "${txtgrn}NRPE plugin has been installed and running normally in your server${txtrst}"
sleep 2
echo
thankyou
}




install_nrpe_centos() {

echo "${txtylw}I will check whether Nagios application exist or not. ${txtrst}"
echo "${txtylw}Please wait a minute...${txtrst}"
sleep 2
if [ -d "/usr/local/nagios/" ]
then
        echo "${txtgrn}It looks like you have installed Nagios yet. ${txtrst}"
        sleep 2
        echo
                echo "${txtylw}Search latest version of NRPE${txtrst}"
                echo "${txtylw}Please wait a minute ...${txtrst}"
                sleep 2
                echo
                echo "${txtylw}Download latest version of NRPE plugin...${txtrst}";sleep 2;
                wget --no-check-certificate https://github.com/NagiosEnterprises/nrpe/archive/master.zip
                sleep 2

                echo


                count=`ls -1 master.zip 2>/dev/null | wc -l `
                if [ $count != 0 ]
                   then
                        echo "${txtgrn}Done${txtrst}"
                        echo
                        nrpe_server_centos
                   else
                        echo ${txtred}I detected there is a problem when I want to download latest NRPE from official web.${txtrst}
                        sleep 2
                        echo ${txtylw}I will install NRPE version 4.0.3 from another source${txtrst}
                                while true
                                do
                                echo
                                read -p "Are you sure want to continue (y/n)? " answer
                                case $answer in
                                [yY]* ) echo "${txtpur}Okay, I will download NRPE version 4.0.3${txtrst}"
                                        sleep 2
                                        echo
                                        echo "${txtylw}Downloading NRPE plugin version 4.0.3${txtrst}";sleep 2;
                                        cd $path;wget --no-check-certificate 'https://archive.org/download/nrpe-4.0.3.tar/nrpe-4.0.3.tar.gz' -O nrpe-4.0.3.tar.gz                                               echo "${txtgrn}NRPE version 3.2.1 has been download and we will install it to your server${txtrst}"
                                        sleep 1
                                        nrpe_403_centos
                                break;;
                                [nN]* ) sleep 2;rm -rf index_latest.html latest* latest_year.txt nagplug.txt php.txt plugin1.txt plugin.txt result.txt reverse.txt index* php.txt year.txt version.txt check_nagios.txt rpm_nagios.txt rpm_nagios_cfg.txt targz.txt wget-log* httpd.txt
                                        thankyou
                                break;;
                         * )     echo "Just enter Y or N, please.";;
                         esac
                         done
        fi


else
        echo
        echo "${txtred}It looks like you have not installed Nagios yet. ${txtrst}"
        echo "${txtred}I think this is not Nagios server but this is client for host monitoring Nagios. ${txtrst}"
        sleep 2
        nrpe_agent_centos
fi

}




check_os_nrpe () {
############ Checking OS  ################
echo "${txtylw}Try to guess your operating system "
sleep 2
if [ -f /etc/debian_version ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep ^NAME | awk 'NR > 1 {print $1}' RS='"' FS='"'` `cat /etc/debian_version`${txtrst}"
sleep 2
echo
install_nrpe_centos
echo
else

if [ -f /etc/redhat-release ]
then
echo "${txtgrn}Your Operating System is `cat /etc/redhat-release`"
sleep 2
echo
install_nrpe_centos
else

if [ -f /etc/SUSE-brand ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep PRETTY_NAME | sed 's/.*=//' | sed 's/^.//' | sed 's/.$//'`${txtrst}"
echo
sleep 2
install_nrpe_centos
echo
else

echo "${txtred}I think your OS is not Debian/Ubuntu or RedHat-Based (CentOS, AlmaLinux, RockyLinux, Fedora) or openSUSE${txtrst}"
echo "${txtred}I am sorry, only work on Linux Debian/Ubuntu, RedHat-Based (CentOS, AlmaLinux, RockyLinux, Fedora), and openSUSE${txtrst}"
echo "${txtred}So, I can not install Nagios in your server${txtrst}"
stop
fi
fi
fi
}





install_nrpe () {
sleep 2
check_user
check_internet
check_os_nrpe
}




##################################################################
#  _____       _      _           _   _             _            #
# |  __ \     | |    | |         | \ | |           (_)           #
# | |  | | ___| | ___| |_ ___    |  \| | __ _  __ _ _  ___  ___  #
# | |  | |/ _ \ |/ _ \ __/ _ \   | . ` |/ _` |/ _` | |/ _ \/ __| #
# | |__| |  __/ |  __/ ||  __/   | |\  | (_| | (_| | | (_) \__ \ #
# |_____/ \___|_|\___|\__\___|   |_| \_|\__,_|\__, |_|\___/|___/ #
#                                              __/ |             #
#                                             |___/              #
#                                                                #
##################################################################



delete_nagios_rpm_centos () {
echo "${txtylw}I will check whether the server is connected to the internet or not. ${txtrst}"
echo "${txtylw}Please wait a minute ...${txtrst}"
ping -q -c5 google.com >> /dev/null
if [ $? = 0 ]
then
echo "${txtgrn}Great, Your server is connected to the internet${txtrst}"
echo "Your System is Connected to Internet" 2> /dev/null  >> $log
sleep 2
echo
else
echo "${txtred}Your server is not connected to the internet so the I can not continue to install Nagios.${txtrst}"
echo "${txtred}Please connect the internet first ...!${txtrst}"
echo "Please connect to the internet ..." 2> /dev/null  >> $log
stop
fi
sleep 2
echo "${txtylw}Please backup your Nagios configuration first and then if you finish backup, press any key to continue ... ${txtrst}"
read -n 1 -s -r;echo
sleep 1
echo
echo "${txtylw}I will start to remove Nagios from your server.${txtrst}"
sleep 2
echo "${txtylw}Please wait a minute...${txtrst}"
sleep 2
echo
echo "${txtylw}I will stop nagios service${txtrst}"
systemctl stop nagios.service 2> /dev/null
service nagios stop 2> /dev/null
sleep 1
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "${txtylw}I will delete user and group nagios${txtrst}"
userdel nagios 2> /dev/null
groupdel nagcmd 2> /dev/null
sleep 2
echo "${txtgrn}Done${txtrst}"
echo
sleep 1
echo "${txtylw}Delete Nagios Packages${txtrst}"
apt-get remove -y nagios* 2> /dev/null
yum remove -y nagios* 2> /dev/null
zypper remove -y nagios 2> /dev/null
sleep 2
echo
echo "${txtgrn}Done${txtrst}"
echo "${txtylw}I will delete nagios folder${txtrst}"
echo
sleep 1
find / -name nagios > nagios_folder.txt
while read -r line; do rm -rf "$line"; done < nagios_folder.txt
#rm -rf nagios_folder.txt rpm_nagios_cfg.txt rpm_nagios.txt
sleep 2
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "${txtgrn}Nagios has been removed from your server.${txtrst}"
rm -rf nagios_folder.txt rpm_nagios_cfg.txt rpm_nagios.txt nag_ubuntu.txt
sleep 3
echo
thankyou
}


delete_nagios_default_centos () {
echo "${txtylw}Please backup your Nagios configuration first and then if you finish backup, press any key to continue ... ${txtrst}"
read -n 1 -s -r;echo
sleep 1
echo
echo "${txtylw}I will start to remove Nagios from your server.${txtrst}"
sleep 2
echo "${txtylw}Please wait a minute...${txtrst}"
sleep 2
echo
echo "${txtylw}I will stop nagios service${txtrst}"
systemctl stop nagios.service 2> /dev/null
service nagios stop 2> /dev/null
sleep 1
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "${txtylw}I will delete user and group nagios${txtrst}"
userdel nagios 2> /dev/null
groupdel nagcmd 2> /dev/null
sleep 2
echo "${txtgrn}Done${txtrst}"
echo
sleep 1
echo "${txtylw}I will delete nagios folder${txtrst}"
find / -name "nagios*" > nagios_folder.txt
while read -r line; do rm -rf "$line"; done < nagios_folder.txt
rm -rf nagios_folder.txt rpm_nagios.txt rpm_nagios_cfg.txt nag_ubuntu.txt
sleep 2
echo "${txtgrn}Done${txtrst}"
sleep 2
echo
echo "${txtgrn}Nagios has been removed from your server.${txtrst}"
sleep 3
echo
thankyou
}



check_delete_nagios_ubuntu () {
echo "${txtylw}I will check whether Nagios application exist or not${txtrst}"
sleep 2

apt list --installed | grep nagios > nag_ubuntu.txt 2>/dev/null
size2=`ls -al | grep nag_ubuntu.txt | awk '{print $5}'`

if [ $size2 != 0 ]
then
        echo "${txtgrn}It looks like you have installed Nagios with yum command. ${txtrst}"
        sleep 2
        echo
                delete_nagios_rpm_centos
fi

check_delete
}


check_delete_nagios_centos () {
echo "${txtylw}I will check whether Nagios application exist or not${txtrst}"
sleep 2

rpm -qa | grep nagios > rpm_nagios.txt 2>/dev/null
size=`ls -al | grep rpm_nagios.txt | awk '{print $5}'`

check_delete
}


#apt list --installed | grep nagios > nag_ubuntu.txt 2>/dev/null
#size2=`ls -al | grep nag_ubuntu.txt | awk '{print $5}'`
check_delete () {

find / -name nagios.cfg > rpm_nagios_cfg.txt
find / -name "nagios-*" >> rpm_nagios_cfg.txt
size1=`ls -al | grep rpm_nagios_cfg.txt | awk '{print $5}'`

if [ -d "/usr/local/nagios/" ]
then
        echo "${txtgrn}It looks like you have installed Nagios using source code with default folder (/usr/local/nagios). ${txtrst}"
        sleep 2
        echo
               delete_nagios_default_centos
elif [ $size != 0 ]
then
        echo "${txtgrn}It looks like you have installed Nagios with yum command. ${txtrst}"
        sleep 2
        echo
                delete_nagios_rpm_centos
#elif [ $size2 != 0 ]
#then
#        echo "${txtgrn}It looks like you have installed Nagios with yum command. ${txtrst}"
#        sleep 2
#        echo
#                delete_nagios_rpm_centos
elif [ $size1 != 0 ]
then
        echo "${txtgrn}It looks like you have installed Nagios using source code without default folder (/usr/local/nagios). ${txtrst}"
        sleep 2
#        rm -rf nag_ubuntu.txt rpm_nagios_cfg.txt rpm_nagios.txt
        echo "${txtgrn}Please delete Your Nagios manually.${txtrst}"
        echo
else
        echo "${txtred}It looks like you have not installed Nagios yet. ${txtrst}"
        echo "${txtred}Please install Nagios using source first. ${txtrst}"
        rm -rf nag_ubuntu.txt rpm_nagios_cfg.txt rpm_nagios.txt
        echo "${txtred}You have not installed Nagios${txtrst}" 2> /dev/null  > $log
        echo;echo
fi

}




check_os_delete () {
############ Checking OS  ################
echo "${txtylw}Try to guess your operating system "
sleep 2
if [ -f /etc/debian_version ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep ^NAME | awk 'NR > 1 {print $1}' RS='"' FS='"'` `cat /etc/debian_version`${txtrst}"
sleep 2
echo
check_delete_nagios_ubuntu
echo
else

if [ -f /etc/redhat-release ]
then
echo "${txtgrn}Your Operating System is `cat /etc/redhat-release`"
sleep 2
echo
check_delete_nagios_centos
else

if [ -f /etc/SUSE-brand ]
then
echo "${txtgrn}Your Operating System is `cat /etc/os-release | grep PRETTY_NAME | sed 's/.*=//' | sed 's/^.//' | sed 's/.$//'`"
echo
sleep 2
check_delete_nagios_centos
echo
else

echo "${txtred}I think your OS is not Debian/Ubuntu or Centos or openSUSE${txtrst}"
echo "${txtred}I am sorry, only work on Linux Debian/Ubuntu, Centos, and openSUSE${txtrst}"
echo "${txtred}So, I can not install Nagios in your server${txtrst}"
stop
fi
fi
fi
}



delete_nagios() {
############ Checking Nagios  ################
check_user
check_os_delete
}
















echo "What do you want from me?"
echo "${txtgrn}1. Install Nagios${txtrst}"
echo "${txtylw}2. Upgrade Nagios${txtrst}"
echo "${txtblu}3. Install NRPE${txtrst}"
echo "${txtred}4. Delete Nagios${txtrst}"
echo -n "Enter Your choice: "
read PILIHAN
echo
case $PILIHAN in
1)
install_nagios ;;
2)
upgrade_nagios ;;
3)
install_nrpe ;;
4)
delete_nagios ;;

*) echo "${txtred}Enter the wrong number and exit the program${txtrst}"
   echo;;

esac