#!/bin/bash

if [[ $(echo "$(cat /proc/uptime | cut -f1 -d ' ') / 3600" | bc) -lt 2 ]];
    then
        exit
else
    bash -c "/usr/bin/python3 /usr/local/bin/notification.py 60" &
    /bin/sleep 1m
    /usr/bin/xset dpms force off;
    /bin/sleep 1m
    /usr/bin/xset dpms force on
fi


















#function timeleft(){
#    if [[ $1 = 60 ]];
#        then
#        /usr/bin/notify-send --urgency=low  "Rest Warning" "$1 Seconds Left"
#    elif [[ $1 -le 10 ]];
#        then
#        killall notify-osd
#        /usr/bin/notify-send --urgency=critical "Rest Warning" "$1 Seconds Left"
#        #killall notify-osd 
#    fi
#    killall notify-osd
#}           