#!/bin/sh

/sbin/ifdown wlan0
/etc/init.d/hostapd stop
sleep 3