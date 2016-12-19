#!/bin/bash 
# Rebooter joxi

JOXI_PID=$(ps -e | grep joxi | awk '{print $1}')

if [ ! -z $JOXI_PID ]; then 
	kill -9 $JOXI_PID
	/usr/bin/joxi & 2>&1 > /dev/null
fi
exit 0 
