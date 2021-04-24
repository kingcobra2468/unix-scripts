#!/bin/bash

# simple battery percentage popup alert

declare -gr SCRIPT=$(realpath $0)
declare -gr SCRIPTPATH=$(dirname $SCRIPT)
declare -gr BATT_ICON_PATH="$SCRIPTPATH/battery.ico"

function get_battery() {

    cat /sys/class/power_supply/BAT0/capacity
}

notify-send -t 3500 -i $BATT_ICON_PATH "Battery" $(get_battery)%