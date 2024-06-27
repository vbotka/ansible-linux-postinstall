#!/bin/bash

# Ansible template
# https://github.com/vbotka/ansible-linux-postinstall/templates/wpa_action.sh.j2
# Example how to activate the script
# wpa_cli -B -i wlan2 -a /root/bin/wpa_action.sh

ifname=$1
cmd=$2

dhclient="/usr/sbin/dhclient"
pidfile="/var/run/dhclient.$ifname.pid"
options_connect="-4 -nw -pf $pidfile -v"
options_disconnect="-4 -r -pf $pidfile -v"
logfile="/tmp/wpa_action.$ifname"
date_format="+%F %T" # Date format in the log messages

my_date=$(date +"$date_format")
printf '%b\n' "$my_date $ifname: $cmd \n" >> "$logfile"

if [ "$cmd" == "CONNECTED" ]; then
    # SSID=`wpa_cli -i$ifname status | grep ^ssid= | cut -f2- -d=`
    $dhclient "$options_connect" "$ifname"
fi
if [ "$cmd" == "DISCONNECTED" ]; then
    $dhclient "$options_disconnect" "$ifname"
fi
exit 0
