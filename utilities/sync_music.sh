#!/bin/bash

# Syncs the music folder from my phone to machine
set -e

declare -r DEVICE_NAME=OnePlus
declare -r DEVICE_PATH=/run/user/1000/gvfs
declare -r MUSIC_PATH=$HOME/Media/Music

BUS=-1
DEV=-1

function get_device_data() {

    usb-devices | grep Manufacturer=$DEVICE_NAME -B 3 | head -n 1
}

function get_bus_n_dev() {
    
    filtered=$(sed -n 's/.*Bus=\([0-9]*\).*Dev#= \([0-9]*\).*/\1 \2/p' <<< $1)
    export BUS=$(echo $filtered | cut -f 1 -d ' ')
    export DEV=$(echo $filtered | cut -f 2 -d ' ')
}

get_bus_n_dev "$(get_device_data)"

if [[ $BUS -eq -1 || $DEV -eq -1 ]]; then

    2>& echo "ERROR GETTING BUS:$BUS or DEV:$DEV"
    exit 
fi

cp -n $DEVICE_PATH/mtp:host=%5Busb%3A001%2C0$DEV%5D/Internal\ shared\ storage/Music/* $MUSIC_PATH