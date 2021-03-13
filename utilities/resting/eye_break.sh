#!/bin/bash

if [[ $(echo "$(cat /proc/uptime | cut -f1 -d ' ') / 3600" | bc) -lt 2 ]]; then
        exit
else
    python3 system_notification.py 60 &
    sleep 1m
    xset dpms force off;
    sleep 1m
    xset dpms force on
fi