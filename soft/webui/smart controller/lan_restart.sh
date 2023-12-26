#!/bin/sh

/sbin/ifdown eth0
sleep 1
/sbin/ifup eth0 2> /tmp/eth0
