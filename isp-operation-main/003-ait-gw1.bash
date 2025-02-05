#!/bin/bash

## Install FreeBSD 13.1 - 64bit 

Login into server by SSH


pkg update
pkg upgrade

portsnap fetch extract update

freebsd-update fetch
freebsd-update install

shutdown -r now

freebsd-update install
shutdown -r now

freebsd-version

pkg install  vim iftop htop mtr iperf3 mc nano bwm-ng


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




vim /etc/rc.conf


#
clear_tmp_enable="YES"
sendmail_enable="NONE"
hostname="hkcore1"
ifconfig_bxe1="up"
ifconfig_bxe2="up"
#ifconfig_bxe2="inet 103.132.18.66/30 up"
#ifconfig_bxe1="inet 103.132.180.1/28 up"
#defaultrouter="103.132.180.1"
sshd_enable="YES"
#ntpdate_enable="YES"
harvest_mask="351"
# Set dumpdev to "AUTO" to enable crash dumps, "NO" to disable
dumpdev="NO"
zfs_enable="YES"
##########
ifconfig_ix0="up"
ifconfig_ix1="up"
###
vlans_ix0="2361 2362 2363 2364 2725"
#
ifconfig_ix0_2361="inet 10.131.160.246/30 up"
ifconfig_ix0_2362="inet 192.168.0.154/30 up"
ifconfig_ix0_2363="inet 10.16.3.126/30 up"
ifconfig_ix0_2364="inet 172.17.19.1/28 up"
#
ifconfig_ix0_2361_alias0="inet 103.132.180.241/29 up"
ifconfig_ix0_2361_alias1="inet 103.132.180.242/29 up"
ifconfig_ix0_2361_alias2="inet 103.132.180.243/29 up"
ifconfig_ix0_2361_alias3="inet 103.132.180.244/29 up"
ifconfig_ix0_2361_alias4="inet 103.132.180.245/29 up"
ifconfig_ix0_2361_alias5="inet 103.132.180.246/29 up"
#
ifconfig_ix0_2362_alias0="inet 103.132.180.249/30 up"
ifconfig_ix0_2362_alias1="inet 103.132.180.250/30 up"
#
ifconfig_ix0_2363_alias0="inet 103.132.180.253/30 up"
ifconfig_ix0_2363_alias1="inet 103.132.180.254/30 up"
#
ifconfig_ix0_2725="inet 10.93.93.138/30 up"
ifconfig_ix0_2725_alias0="inet 103.132.180.230/30 up"
#
#ifconfig_ix0_2361="inet 172.17.19.1/29 up"
#defaultrouter="10.131.160.245"
#
##########
vlans_ix1="2851 2852 2853 2854"
## IPT/INT PEERING
ifconfig_ix1_2851="inet 103.132.180.1/28 up"
ifconfig_ix1_2851_alias0="inet 172.28.130.33/30 up"
## GGC+FNA PEERING
ifconfig_ix1_2852="inet 172.28.131.1/28 up"
## P2P WITH BDIX CCR 1009
ifconfig_ix1_2853="inet 100.64.180.2/28 up"



#
#
#
#vlans_ix2="2851 2854"
#ifconfig_ix2_2851="inet 103.132.180.1/28 up"
####
ifconfig_bxe2="up"
#ifconfig_bxe2="inet 103.132.180.33/28 up"
####
frr_enable="yes"
frr_daemons="zebra staticd bgpd"
bsnmpd_enable="YES"
#
#mpd_enable="YES"
## FIREWALL
firewall_enable="YES"
firewall_script="/etc/ipfw-core-nat.sh"
#firewall_script="/opt/ipfw-core-nat.sh"
firewall_nat_enable="YES"
firewall_type="open"
firewall_logging="no"








vim /etc/sysctl.conf

# $FreeBSD$
#
#  This file is read when going to multi-user and its contents piped thru
#  ``sysctl'' to adjust kernel values.  ``man 5 sysctl.conf'' for details.
#

# Uncomment this to prevent users from seeing information about processes that
# are being run under another UID.
#security.bsd.see_other_uids=0
vfs.zfs.min_auto_ashift=12
#
#########################################
net.inet.ip.dummynet.io_fast=1
net.inet.icmp.icmplim=0
net.inet.ip.forwarding=1
net.inet.ip.redirect=0
net.inet.ip.fw.one_pass=1
net.inet.tcp.mssdflt=1460
net.inet.tcp.minmss=536
net.inet.tcp.syncache.rexmtlimit=0
net.inet.tcp.cc.abe=1
net.inet.tcp.cc.htcp.rtt_scaling=1
net.inet.ip.maxfragpackets=0
net.inet.ip.maxfragsperpacket=0
net.inet.tcp.abc_l_var=44
net.route.netisr_maxqlen=2048
kern.ipc.maxsockbuf=614400000
kern.random.fortuna.minpoolsize=128
kern.coredump=0
net.inet.raw.maxdgram=131072
net.inet.raw.recvspace=131072
net.inet.tcp.syncookies=0
net.inet.tcp.tso=0
net.inet.udp.checksum=0
net.inet.tcp.recvspace=4194304
net.inet.tcp.sendspace=4194304
net.inet.tcp.sendbuf_max=16777216
net.inet.tcp.recvbuf_max=16777216
net.inet.tcp.sendbuf_auto=1
net.inet.tcp.recvbuf_auto=1
net.inet.tcp.sendbuf_inc=524288
net.inet.tcp.hostcache.expire=1
net.inet.tcp.cc.algorithm=htcp
security.bsd.see_other_uids=0
security.bsd.see_other_gids=0
net.inet.udp.blackhole=1
net.inet.tcp.blackhole=2
net.inet.tcp.isn_reseed_interval=4500
net.isr.dispatch=deferred
net.inet.tcp.ecn.enable=1
net.inet.tcp.fast_finwait2_recycle=1
net.inet.tcp.nolocaltimewait=1
hw.ibrs_disable=1
#
net.inet.tcp.rfc6675_pipe=1
hw.intr_storm_threshold=25000000
kern.random.harvest.mask=351
#
net.inet.ip.fw.dyn_max=5000000
net.inet.ip.fw.dyn_buckets=5000000
net.inet.ip.fw.dyn_keepalive=1
net.inet.ip.dummynet.hash_size=65536
net.inet.ip.fw.dyn_ack_lifetime=300
net.inet.ip.fw.dyn_syn_lifetime=20
net.inet.ip.fw.dyn_fin_lifetime=1
net.inet.ip.fw.dyn_short_lifetime=5
kern.maxvnodes=100000000
kern.ipc.somaxconn=65535
net.inet.tcp.maxtcptw=80960
net.inet.ip.dummynet.pipe_slot_limit=1000
net.inet.ip.intr_queue_maxlen=4096
net.route.netisr_maxqlen=4096
#
# Disable Ethernet flow control
dev.ix.0.fc=0
dev.ix.1.fc=0
#####################################################



vim /boot/loader.conf

#... Custom Section ...#
net.inet.rss.enabled="1"
net.inet.rss.bits="7"
net.inet.tcp.tcbhashsize="16384"
net.isr.bindthreads="0"
net.isr.direct="0"
net.isr.dispatch="deferred"
net.isr.direct_force="0"
net.isr.maxthreads="-1"
vm.kmem_size="2G"
kern.ipc.nmbclusters="1000000"
kern.ipc.nmbjumbop="262144"
kern.ipc.nmbjumbo9="65536"
kern.ipc.nmbjumbo16="32768"
kern.maxusers="1024"
cc_htcp_load="YES"
net.inet.tcp.hostcache.cachelimit="0"
net.link.ifqmaxlen="16384"
net.inet.tcp.soreceive_stream="1"
net.isr.defaultqlimit="4096"
net.isr.maxqlimit="1000000"
hw.vga.textmode="1"
#... Netwrok Card Tuning ... #
hw.ix.flow_control="0"
hw.ix.unsupported_sfp="1"
hw.ix.allow_unsupported_sfp="1"
hw.ix.intr_storm_threshold="65536"
hw.ix.max_interrupt_rate="-1"
legal.intel_ix.license_ack="1"
hw.ix.rx_process_limit="-1"
hw.ix.tx_process_limit="-1"
hw.ix.num_queues="48"
hw.ix.enable_aim="1"
hw.ix.enable_msi="1"
hw.ix.enable_msix="1"
hw.pci.enable_msi="1"
hw.pci.enable_msix="1"
hw.ix.rxd="4096"
hw.ix.txd="4096"
#... Cyclnoe ...#
#


vim /etc/ipfw-core-nat.sh


#!/bin/sh
ipfw -q -f flush
ipfw -f pipe flush
ipfw -f nat flush
#ipfw -q disable one_pass

##### FNA+GGC ADDRESS TABLE
ipfw table 1 flush
ipfw table 1 add 103.131.159.0/26
ipfw table 1 add 103.131.157.48/28
ipfw table 1 add 103.107.163.0/24
ipfw table 1 add 103.148.172.64/26
ipfw table 1 add 163.47.157.160/27
ipfw table 1 add 163.47.157.128/27
ipfw table 1 add 163.47.158.96/28
ipfw table 1 add 103.131.157.192/26
ipfw table 1 add 103.179.62.0/26

### HK OWN GGC
#ipfw table 1 add 34.104.32.0/21
#ipfw table 1 add 45.113.132.96/27
#ipfw table 1 add 45.113.133.64/27
#ipfw table 1 add 103.21.42.192/26



########## NAT Definition

##### INTERNET
ipfw -q nat 11 config ip 103.132.180.241
ipfw -q nat 12 config ip 103.132.180.242
ipfw -q nat 13 config ip 103.132.180.243
ipfw -q nat 14 config ip 103.132.180.244
ipfw -q nat 15 config ip 103.132.180.245
ipfw -q nat 16 config ip 103.132.180.246
#
ipfw -q nat 21 config ip 103.132.180.249
ipfw -q nat 22 config ip 103.132.180.250
#
ipfw -q nat 31 config ip 103.132.180.253
ipfw -q nat 32 config ip 103.132.180.254
#
ipfw -q nat 35 config ip 103.132.180.230
#ipfw -q nat 32 config ip 103.132.180.254

########## System Rules


ipfw -q add 50 deny all from any 25 to any in
ipfw -q add 51 deny all from any 25 to any out


ipfw -q add 100 pass all from any to any via lo0
ipfw -q add 101 deny all from any to 127.0.0.0/8
ipfw -q add 102 deny ip from 127.0.0.0/8 to any


#### YOUTUBE+FACEBOOK (TOGETHER)
ipfw -q pipe 500 config bw 40Mbits/s mask dst-ip 0x0007fffff
ipfw -q add 500 pipe 500 ip from "table(1)" to 10.56.0.0/13 out xmit ix1.2851 


###### PKGT BW #########################################################
ipfw -q pipe 502 config bw 8Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 502 pipe 502 ip from not "table(1)" to 10.56.0.0/16 out xmit ix1.2851  

ipfw -q pipe 503 config bw 8Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 503 pipe 503 ip from not "table(1)" to 10.57.0.0/16 out xmit ix1.2851

ipfw -q pipe 504 config bw 8Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 504 pipe 504 ip from not "table(1)" to 10.58.0.0/16 out xmit ix1.2851

ipfw -q pipe 505 config bw 10Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 505 pipe 505 ip from not "table(1)"  to 10.59.0.0/16 out xmit ix1.2851

ipfw -q pipe 507 config bw 15Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 507 pipe 507 ip from not "table(1)"  to 10.60.0.0/16 out xmit ix1.2851

ipfw -q pipe 530 config bw 20Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 530 pipe 530 ip from not "table(1)"  to 10.61.0.0/16 out xmit ix1.2851

ipfw -q pipe 531 config bw 25Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 531 pipe 531 ip from not "table(1)"  to 10.62.0.0/16 out xmit ix1.2851

ipfw -q pipe 532 config bw 30Mbits/s mask dst-ip 0x0000ffff
ipfw -q add 532 pipe 532 ip from not "table(1)"  to 10.63.0.0/16 out xmit ix1.2851


##### UPLOAD CONTROL #########
#ipfw -q pipe 550 config bw 30Mbits/s mask src-ip 0x0007ffff
#ipfw -q add 550 pipe 550 ip from 10.56.0.0/13 to any in recv ix1.2851

#ipfw -q pipe 550 config bw 30Mbits/s mask src-ip 0xffffffff
#ipfw -q add 550 pipe 550 ip from any to any in recv ix1.2851


#### INTERNET-NAT
#########################################################################


### NAT OUT

ipfw -q add 1025 nat 11 ip from 10.56.0.0/16 to any out via ix0.2361
ipfw -q add 1026 nat 14 ip from 10.57.0.0/16 to any out via ix0.2361
ipfw -q add 1027 nat 13 ip from 10.58.0.0/16 to any out via ix0.2361
ipfw -q add 1031 nat 15 ip from 10.59.0.0/16 to any out via ix0.2361
ipfw -q add 1032 nat 16 ip from 10.60.0.0/16 to any out via ix0.2361
ipfw -q add 1033 nat 14 ip from 10.61.0.0/16 to any out via ix0.2361
ipfw -q add 1034 nat 15 ip from 10.62.0.0/16 to any out via ix0.2361
ipfw -q add 1035 nat 16 ip from 10.63.0.0/16 to any out via ix0.2361

ipfw -q add 1036 nat 16 ip from 100.64.180.0/28 to any out via ix0.2361


### NAT IN
ipfw -q add 1081 nat 11 ip from any to 103.132.180.241 in via ix0.2361
ipfw -q add 1082 nat 12 ip from any to 103.132.180.242 in via ix0.2361
ipfw -q add 1083 nat 13 ip from any to 103.132.180.243 in via ix0.2361
ipfw -q add 1084 nat 14 ip from any to 103.132.180.244 in via ix0.2361
ipfw -q add 1085 nat 15 ip from any to 103.132.180.245 in via ix0.2361
ipfw -q add 1086 nat 16 ip from any to 103.132.180.246 in via ix0.2361



# GGC NAT
ipfw -q add 1045 nat 21 ip from 10.56.0.0/16 to any out via ix0.2362
ipfw -q add 1046 nat 22 ip from 10.57.0.0/16 to any out via ix0.2362
ipfw -q add 1047 nat 21 ip from 10.58.0.0/16 to any out via ix0.2362
ipfw -q add 1048 nat 22 ip from 10.59.0.0/16 to any out via ix0.2362
ipfw -q add 1049 nat 21 ip from 10.60.0.0/16 to any out via ix0.2362
ipfw -q add 1050 nat 22 ip from 10.61.0.0/16 to any out via ix0.2362
ipfw -q add 1051 nat 21 ip from 10.62.0.0/16 to any out via ix0.2362
ipfw -q add 1053 nat 22 ip from 10.63.0.0/16 to any out via ix0.2362


### NAT IN
ipfw -q add 1091 nat 21 ip from any to 103.132.180.249 in via ix0.2362
ipfw -q add 1092 nat 22 ip from any to 103.132.180.250 in via ix0.2362


# FNA NAT
ipfw -q add 1055 nat 31 ip from 10.56.0.0/16 to any out via ix0.2363
ipfw -q add 1056 nat 32 ip from 10.57.0.0/16 to any out via ix0.2363
ipfw -q add 1057 nat 31 ip from 10.58.0.0/16 to any out via ix0.2363
ipfw -q add 1058 nat 32 ip from 10.59.0.0/16 to any out via ix0.2363
ipfw -q add 1059 nat 31 ip from 10.60.0.0/16 to any out via ix0.2363
ipfw -q add 1060 nat 32 ip from 10.61.0.0/16 to any out via ix0.2363
ipfw -q add 1061 nat 31 ip from 10.62.0.0/16 to any out via ix0.2363
ipfw -q add 1063 nat 32 ip from 10.63.0.0/16 to any out via ix0.2363


### FNA IN
ipfw -q add 1098 nat 31 ip from any to 103.132.180.253 in via ix0.2363
ipfw -q add 1099 nat 32 ip from any to 103.132.180.254 in via ix0.2363


# FNA NAT
ipfw -q add 1101 nat 35 ip from 10.56.0.0/16 to any out via ix0.2725
ipfw -q add 1102 nat 35 ip from 10.57.0.0/16 to any out via ix0.2725
ipfw -q add 1103 nat 35 ip from 10.58.0.0/16 to any out via ix0.2725
ipfw -q add 1104 nat 35 ip from 10.59.0.0/16 to any out via ix0.2725
ipfw -q add 1105 nat 35 ip from 10.60.0.0/16 to any out via ix0.2725
ipfw -q add 1106 nat 35 ip from 10.61.0.0/16 to any out via ix0.2725
ipfw -q add 1107 nat 35 ip from 10.62.0.0/16 to any out via ix0.2725
ipfw -q add 1108 nat 35 ip from 10.63.0.0/16 to any out via ix0.2725


### FNA IN
ipfw -q add 1120 nat 35 ip from any to 103.132.180.230 in via ix0.2725











