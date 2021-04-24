#!/bin/bash

declare -gr SCRIPT=$(realpath $0)
declare -gr SCRIPTPATH=$(dirname $SCRIPT)
declare -gr BRIGHTNESS_ICON_PATH="$SCRIPTPATH/light_bulb.ico"
declare -gr CHANGE_FACTOR=5

function get_brightness() {

    brightness=$(xbacklight | cut -f1 -d .)
       
    if [[ $brightness -ne 100 && $brightness -ne 0 ]]; then
         brightness=$(($brightness + 1)) #xbindkeys outputs 0.5 lower than supposed to be in 10pts incraments
    fi

    notify-send -t 300 -i $BRIGHTNESS_ICON_PATH "Brightness" "\t$brightness%"
}

if [[ $1 == "inc" ]]; then

    xbacklight -inc $CHANGE_FACTOR
    
elif [[ $1 == "dec" ]]; then

    xbacklight -dec $CHANGE_FACTOR 
fi

#pkill notify
get_brightness
