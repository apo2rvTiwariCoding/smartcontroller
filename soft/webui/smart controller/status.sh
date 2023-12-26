#!/bin/sh

if [ -e "/tmp/status-running" ]; then
echo Already running
else
touch /tmp/status-running
/usr/bin/uptime > /tmp/status
/usr/bin/free -m >> /tmp/status
/bin/df >> /tmp/status
/sbin/ifconfig >> /tmp/status
/sbin/route -n >> /tmp/status
/bin/cat /etc/resolv.conf >> /tmp/status
/sbin/iwlist wlan1 channel > /tmp/wlanchan

/var/www/smart/status.pl
/var/www/smart/weather.pl
/var/www/smart/sync_out.pl
/var/www/smart/sync_in.pl

if [ -e "/tmp/faclist" ]; then
    /var/www/smart/factory.pl
    exit
fi

rm /tmp/status-running
fi
