#!/bin/bash

## Install FreeBSD 13.1 - 64bit 

Login into server by SSH


pkg update
pkg upgrade

pkg install  vim iftop htop mtr iperf3 mc nano bwm-ng


portsnap fetch extract update

freebsd-update fetch
freebsd-update install

shutdown -r now

freebsd-update install
shutdown -r now

freebsd-version

###########################################################
### COMPILE KERNEL ####
###########################################################

cd /usr/src/sys/amd64/conf/

cp GENERIC mycustom-kernel-x86-64
vim mycustom-kernel-x86-64
cpu		HAMMER
ident		mycustom-kernel-x86-64


# CPU frequency control
device          cpufreq

makeoptions     WITH_EXTRA_TCP_STACKS=1
options         RATELIMIT
options         TCPHPTS


options         IPFIREWALL
options         IPFIREWALL_VERBOSE
options         IPFIREWALL_VERBOSE_LIMIT
options         IPFIREWALL_DEFAULT_TO_ACCEPT
options         IPFIREWALL_NAT
options         LIBALIAS
options         DUMMYNET
options         IPDIVERT
options         HZ=1000

options         VIMAGE
options         NULLFS

options         NETGRAPH
options         NETGRAPH_ASYNC
options         NETGRAPH_BPF
options         NETGRAPH_ECHO
options         NETGRAPH_ETHER
options         NETGRAPH_HOLE
options         NETGRAPH_IFACE
options         NETGRAPH_KSOCKET
options         NETGRAPH_L2TP
options         NETGRAPH_LMI
options         NETGRAPH_MPPC_ENCRYPTION
options         NETGRAPH_ONE2MANY
options         NETGRAPH_PPP
options         NETGRAPH_PPTPGRE
options         NETGRAPH_RFC1490
options         NETGRAPH_SOCKET
options         NETGRAPH_TEE
options         NETGRAPH_TTY
options         NETGRAPH_UI
options         NETGRAPH_VJC
options         NETGRAPH_EIFACE
options         NETGRAPH_SOCKET


options         TCP_SIGNATURE
options         MROUTING
options         ROUTETABLES=16
options         KDB_UNATTENDED



make -j 16 KERNCONF=mycustom-kernel-x86-64 buildkernel
make installkernel KERNCONF=mycustom-kernel-x86-64

reboot


###########################################################
### COMPILE KERNEL ####
###########################################################

kldload /boot/kernel/tcp_bbr.ko
sysctl net.inet.tcp.functions_available
sysctl net.inet.tcp.functions_default=bbr
sysctl net.inet.tcp.functions_available












cat /etc/sysctl.conf

#
net.inet.ip.forwarding=1
net.inet.ip.redirect=0
#net.inet.ip.fw.one_pass=0
net.inet.tcp.mssdflt=1460
net.inet.tcp.minmss=536
net.inet.tcp.syncache.rexmtlimit=0
net.inet.ip.maxfragpackets=0
net.inet.ip.maxfragsperpacket=0
net.inet.tcp.abc_l_var=44
net.inet.ip.intr_queue_maxlen=2048
net.route.netisr_maxqlen=2048
kern.ipc.maxsockbuf=614400000
kern.coredump=0
net.inet.raw.maxdgram=16384
net.inet.raw.recvspace=16384
kern.ipc.somaxconn=2048
net.inet.tcp.syncookies=0
net.inet.tcp.tso=1
net.inet.tcp.recvspace=4194304
net.inet.tcp.sendspace=4194304
net.inet.tcp.sendbuf_max=16777216
net.inet.tcp.recvbuf_max=16777216
net.inet.tcp.sendbuf_auto=1
net.inet.tcp.recvbuf_auto=1
net.inet.tcp.sendbuf_inc=524288
net.inet.tcp.recvbuf_inc=524288
net.inet.tcp.hostcache.expire=1
net.inet.tcp.cc.algorithm=htcp
security.bsd.see_other_uids=0
security.bsd.see_other_gids=0
net.inet.udp.blackhole=1
net.inet.tcp.blackhole=2
net.inet.tcp.isn_reseed_interval=4500
#
net.inet.tcp.rfc6675_pipe=1
hw.intr_storm_threshold=25000000
#


root@BSDGW2:~ # cat /etc/ipfw-isp1gw1.sh
#!/bin/sh
ipfw -q -f flush
ipfw -f pipe flush
ipfw -f nat flush
ipfw -q disable one_pass

fwcmd="ipfw -q add"

ipfw -q add 50 pass all from any to any via lo0
ipfw -q add 51 deny all from any to 127.0.0.0/8
ipfw -q add 52 deny ip from 127.0.0.0/8 to any


######## Configure NAT
ipfw -q nat 10 config ip 43.230.123.57


### BLOCK RULES
ipfw -q add 90 deny tcp from any to any 25 in
ipfw -q add 91 deny tcp from any to any 25 out
ipfw -q add 92 deny tcp from any to any 67 in
ipfw -q add 93 deny tcp from any to any 67 out


### UPLLOAD CONTROL-ALL IP
ipfw -q pipe 105 config bw 10Mbit/s mask src-ip 0xffffffff
ipfw -q add 105 pipe 105 ip from any to any out via ix1.450

ipfw -q pipe 106 config bw 10Mbit/s mask src-ip 0xffffffff
ipfw -q add 106 pipe 106 ip from any to any out via ix1.451


ipfw -q pipe 111 config bw 10Mbit/s
ipfw -q add 111 pipe 111 ip from any to any out via ng0

ipfw -q pipe 112 config bw 10Mbit/s
ipfw -q add 112 pipe 112 ip from any to any out via ng1

### INTERNET-NAT

ipfw -q add 10001 nat 10 ip from 10.20.30.0/24 to any out via re2
ipfw -q add 10002 nat 10 ip from 10.16.32.0/24 to any out via re2
ipfw -q add 10003 nat 10 ip from 10.20.24.0/30 to any out via re2
ipfw -q add 10070 nat 10 ip from any to 43.230.123.57  in via re2 ## IN




root@BSDGW2:~ # cat /etc/rc.conf
####
hostname="BSDGW2"
ifconfig_re2="inet 43.230.123.57 netmask 255.255.255.240"
defaultrouter="43.230.123.49"
sshd_enable="YES"
# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="AUTO"
zfs_enable="YES"
#########
#mpd_enable="YES"

gateway_enable="YES"

###############
vlans_ix1="450 451"
#ifconfig_ix1_450="inet 10.20.24.1/30 up"
#ifconfig_ix1_451="inet 10.20.24.5/30 up"
ifconfig_ix1_450="up"
ifconfig_ix1_451="up"


###############
ifconfig_re0="up"
ifconfig_re1="up"
ifconfig_ix0="up"
ifconfig_ix1="up"
#ifconfig_ix1.450="up"
#ifconfig_ix1.451="up"
#cloned_interfaces="lagg0"
#ifconfig_lagg0="laggproto loadbalance laggport re0 laggport re1"

firewall_enable="YES"
firewall_script="/etc/ipfw-isp1gw1.sh"
firewall_nat_enable="YES"
#firewall_nat_interface="re2"
firewall_type="open"
firewall_logging="no"

#/usr/bin/mpd5-server


root@BSDGW2:~ # cat /usr/bin/mpd5-server
#!/bin/sh
/usr/local/sbin/mpd5 -b -d /usr/local/etc/mpd50 -p /var/run/vlan450.pid -s pppoe_server
/usr/local/sbin/mpd5 -b -d /usr/local/etc/mpd51 -p /var/run/vlan451.pid -s pppoe_server1

 cat /usr/local/etc/mpd50/mpd.conf | more
 
################
startup:
        set user omni tech admin
        set console self 127.0.0.1 5005
        set console open
        set web self 0.0.0.0 5080
        set web open

default:
        load pppoe_server


pppoe_server:
        create bundle template poes_b
        set ippool add p0 10.16.33.0 10.16.33.254
        set ipcp ranges 10.20.30.1/32 ippool p0
        set ipcp dns 9.9.9.11
        set ipcp no vjcomp

        set iface group pppoe
        set iface route default
        set iface idle 0
        set iface disable on-demand
        set iface disable proxy-arp
        set iface enable tcpmssfix
        set iface mtu 1500

        create link template poes_l pppoe
        set link action bundle poes_b
        set auth max-logins 1
        set pppoe iface ix1.450
        set link no multilink
        set link no pap chap
        set link enable pap
        set link keep-alive 60 180
        set link max-redial -1
        set link mru 1492
        set link latency 1
        set link enable incoming

        set radius server 103.144.200.41 "omni-one" 1812
        set radius retries 3
        set radius timeout 10
        set auth enable radius-auth
        set radius me 43.230.123.57



root@BSDGW2:~ # cat /usr/local/etc/mpd51mpd.conf | more
################
startup:
        set user omni tech admin
        set console self 127.0.0.1 5006
        set console open
        set web self 0.0.0.0 5081
        set web open

default:
        load pppoe_server1


pppoe_server1:
        create bundle template poes_b
        set ippool add p0 10.16.35.0 10.16.35.254
        set ipcp ranges 10.20.30.2/32 ippool p0
        set ipcp dns 9.9.9.11
        set ipcp no vjcomp

        set iface group pppoe
        set iface route default
        set iface idle 0
        set iface disable on-demand
        set iface disable proxy-arp
        set iface enable tcpmssfix
        set iface mtu 1500

        create link template poes_l pppoe
        set link action bundle poes_b
        set auth max-logins 1
        set pppoe iface ix1.451
        set link no multilink
        set link no pap chap
        set link enable pap
        set link keep-alive 60 180
        set link max-redial -1
        set link mru 1492
        set link latency 1
        set link enable incoming

        set radius server 103.144.200.41 "omni-one" 1812
        set radius retries 3
        set radius timeout 10
        set auth enable radius-auth
        set radius me 43.230.123.57




################## DragonFLYBSD #########



/usr/local/etc/pkg/repos/df-latest.conf 

AUTO: {
    url             : https://pkg.dragonflybsd.org/pkg/${ABI}/LATEST
    mirror_type     : HTTP
    enabled         : yes
}

Avalon: {
    [...]
    enabled         : no
}




########### DRAGON FLY BSD ### LAB WORKS #######

ifconfig 10X.14Y.20Z.45/28 up
route add default 10X.14Y.20Z.33

echo "nameseerver 8.8.8.8" > /etc/resolv.conf


cd /usr/local/etc/pkg/repos/
cp df-latest.conf.sample df-latest.conf
echo "" > df-latest.conf

ee df-latest.conf

root@:~ # cat /usr/local/etc/pkg/repos/df-latest.conf
# If multiple repositories are enabled, they are ordered by their priorities
# and then listing orders.

# United States, California
Avalon: {
        url             : https://mirror-master.dragonflybsd.org/dports/${ABI}/LATEST,
        mirror_type     : NONE,
        signature_type  : NONE,
        pubkey          : NONE,
        fingerprints    : /usr/share/fingerprints,
        priority        : 0,
        enabled         : no
}

# Asia
#

# South Korea
# Korea FreeBSD Users Group
KFBUG: {
        url             : https://ftp.kr.freebsd.org/pub/dragonflybsd/dports/${ABI}/LATEST,
        enabled         : yes
}
 

pkg update
pkg upgrade

pkg install vim mtr nano htop bwm-ng iftop wget net-snmp frr7
rehash



root@:~ # cat /etc/rc.conf
# Basic rc.conf, adjust according to your needs
#
nfs_reserved_port_only="YES"
sshd_enable="YES"
nfs_client_enable="YES"
rpc_umntall_enable="NO"
dumpdev="/dev/vbd0s1b"  # via installer configuration


ifconfig_em0="inet 10X.14Y.20Z.45/28 up"
defaultrouter="10X.14Y.20Z.33"


frr_enable="yes"
frr_daemons="zebra staticd bgpd"


tzsetup

#cd /usr/
#make dports-create-shallow



pkg install frr7
vim /etc/sysctl.conf

frr_enable="yes"
frr_daemons="zebra staticd bgpd"


sysctl kern.ipc.maxsockbuf=16777216

vim /etc/sysctl.conf
kern.ipc.maxsockbuf=16777216


rehash
cd /usr/local/etc/frr
cp zebra.conf.sample zebra.conf
cp bgpd.conf.sample bgpd.conf
cp vtysh.conf.sample vtysh.conf
cp staticd.conf.sample staticd.conf
chown -R frr:frr *
cd ..
chown -R frr:frr frr
/usr/local/etc/rc.d/frr restart
vtysh




root@:~ # cat ipfw3_sample.sh
#!/bin/sh
kldload ipfw3
kldload ipfw3_nat
kldload ipfw3_layer4
#kldload ipfw3_dummynet

ipfw3 flush

ipfw3 add 1 allow all

ipfw3 nat 1 config ip 103.144.200.45
ipfw3 add 2 nat 1 all via em0

#ipfw3 add 2 check-state
#ipfw3 add 3 allow all established
#ipfw3 add 4 allow all out via em0 keep-state
#ipfw3 add 100 allow all
#ipfw3 add deny all





### https://www.dragonflybsd.org/docs/ipfw3/
sysctl net.filters_default_to_accept=1
echo "net.filters_default_to_accept=1" >> /etc/sysctl.conf

kldload ipfw3 ipfw3_nat ipfw3_layer4 dummynet


### rc.conf
powerd_enable="NO"
firewall_enable="YES"
firewall_script="/etc/rc.firewall"
firewall_type="OPEN"

gateway_enable="YES"
ipfw3_enable="YES"
ipfw3_modules="ipfw3 ipfw3_nat ipfw3_layer4 dummynet"


## download source kernel
cd /usr/
make src-create-shallow

   
Change to the /usr/src directory.

cd /usr/src

#Compile the kernel.
cp X86_64_GENERIC X86_64_ROUTER
vim X86_64_ROUTER

###IFPW ####
options         IPFIREWALL
options         IPFIREWALL_VERBOSE
options         IPFIREWALL_DEFAULT_TO_ACCEPT
options         IPFIREWALL_NAT
options         LIBALIAS
options         DUMMYNET
options         IPDIVERT
options         HZ=1000



make -j 3 buildkernel KERNCONF=X86_64_ROUTER

#Install the new kernel.
make installkernel KERNCONF=X86_64_ROUTER




/usr/obj/usr/src/amd64.amd64/sys/XROUTER/modules/usr/src/sys/modules/ixl
/usr/obj/usr/src/amd64.amd64/sys/XROUTER/modules/usr/src/sys/modules/ix

define RSS 1



#################################
pciconf -lv | grep -A1 -B3 network

# https://www.freshports.org/net/intel-ix-kmod/
pkg install net/intel-ix-kmod
pkg install intel-ix-kmod

if_ix_updated_load="YES"

to your /boot/loader.conf 

sysctl net.inet.rss.enabled
sysctl -a | grep -i 'isr.bindthreads\|isr.maxthreads\|inet.rss.enabled\|inet.rss.bits'
kldstat


   

https://forums.freebsd.org/threads/building-driver-module-in-a-rss-enabled-custom-kernel-doesnt-seems-to-enable-rss.74507/
# cat /usr/obj/root/freebsd_12/amd64.amd64/sys/GENERIC/opt_rss.h
#define RSS 1 << Looks, this opt_rss.h is generic for the particular installation>>

# File
find / -type f -name "file name"
# Directory
find / -type d -name "directory name"


/usr/libexec/locate.updatedb


ifconfig_vtnet2="DHCP -lro -tso -rxcsum -txcsum"
ifconfig_vtnet1="inet 192.168.1.254 netmask 255.255.255.0 -lro -tso -rxcsum -txcsum

sysctl net.inet.tcp.tso=0

