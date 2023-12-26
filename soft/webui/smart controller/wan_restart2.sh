#!/bin/sh

sleep 2
killall wpa_supplicant
/sbin/ifup wlan1 2> /tmp/wlan1
