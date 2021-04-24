#!/bin/bash

# records the time on the battery since machine was booted

if ! [[ -f /tmp/batstart ]];then
    cat /sys/class/power_supply/BAT0/capacity > /tmp/batstart
    exit
fi

batteryO=$(cat /tmp/batstart)
batteryN=$(cat /sys/class/power_supply/BAT0/capacity)
timeOn=$(cat /proc/uptime | cut -f1 -d ' ')

printf "%i Percent Went Down for %02.fH:%02.fM\n" $((batteryO-batteryN)) $(echo "$timeOn/3600" | bc) $(echo "($timeOn%3600)/60" | bc)

