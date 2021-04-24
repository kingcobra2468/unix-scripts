#!/bin/bash

declare -gr STATE_FILE="./.outdoor_mode_state"
declare -gr OUTDOOR_MODE_GAMMA="1.3"
declare -gr INDOOR_MODE_GAMMA="1.0"

function read_state() {

    cat $STATE_FILE 
}

function flip_state() {

    state=$(read_state)

    if [[ $state -eq 0 ]]; then

        echo 1 > $STATE_FILE
        xgamma -gamma $OUTDOOR_MODE_GAMMA
    elif [[ $state -eq 1 ]]; then

        echo 0 > $STATE_FILE
        xgamma -gamma $INDOOR_MODE_GAMMA
    fi
}

flip_state