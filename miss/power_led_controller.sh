#!/bin/bash

# script toggles turns on/off the power light of the T430 since it is bright 
# when laptop used at night

declare -gr POWER_LED_PATH="/sys/class/leds/tpacpi::power/brightness"

function led_state() {

    state=
    if [[ $1 == "enable" ]]; then
        state=1
    elif [[ $1 == "disable" ]]; then
        state=0
    fi
    
    echo $state | sudo tee $POWER_LED_PATH
}

if [[ $# -ne 1 ]]; then
    echo "Argument missing"
    exit 1
elif [[ $1 != "enable" && $1 != "disable" ]]; then
    echo "Argument invalid: ONLY 'enable' or 'disable'"
    exit 1
else
    
    led_state $1
fi	
