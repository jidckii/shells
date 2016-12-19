#!/bin/bash 
# Rebooter joxi

JOXI_PID=$(ps -e | grep joxi | awk '{print $1}')

if [ ! -z $JOXI_PID ]; then 
	kill -9 $JOXI_PID
	/usr/bin/joxi &
fi
exit 0 
