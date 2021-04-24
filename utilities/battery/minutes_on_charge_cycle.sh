#!/bin/bash

# script for monitoring  and logging battery cycle 
# ~/.battery_cycles file format: (MIN_ON_CHARGE BATTERY_DEGREGATION BATT_CAPACITY_BEGAN BATT_CAPACITY_ENDED)

declare -gr LOG_FILE_PATH="$HOME/.battery_cycles"

function check_log_file_exists() {

    if [[ ! -e $LOG_FILE_PATH ]]; then
        touch $LOG_FILE_PATH
        start_new_record
    fi

}

# fetches the current battery capactiy
function current_capacity() {

    echo $(cat /sys/class/power_supply/BAT0/capacity)
}

# checks if battery charging/discharging
function battery_charging() {

    status=$(cat /sys/class/power_supply/BAT0/status)

    if [[ $status == "Discharging" ]]; then
        echo 0
    else
        echo 1
    fi
}

# checks if battery topped up (passed threshold of 95%)
function battery_topped_up() {

    if [[ $(current_capacity) -gt 95 ]]; then
        echo 1
    else
        echo 0
    fi
}

# checks starting capactiy of log
function starting_capacity() {

    get_starting_capacity=$(tail -n 1 $LOG_FILE_PATH | cut -f 3 -d ' ')
    echo $get_starting_capacity
}

# pushes buffer of minutes on charging for this battery cycle
function update_minutes_on_charge() {

    get_minutes_on_charge=$(tail -n 1 $LOG_FILE_PATH | cut -f 1 -d ' ')
    sed -in "$ s/^\([0-9]*\s\)\(.*\)$/$(($get_minutes_on_charge + 1)) \2/" $LOG_FILE_PATH
}

# fetches minutes on charge
function minutes_on_charge() {

    get_minutes_on_charge=$(tail -n 1 $LOG_FILE_PATH | cut -f 1 -d ' ')
    echo $get_minutes_on_charge
}

# beautify print of minutes on charge
function minutes_on_charge_formatted() {

    get_minutes_on_charge=$(tail -n 1 $LOG_FILE_PATH | cut -f 1 -d ' ')

    # convertion logic
    hours_on_charge=$(echo "$get_minutes_on_charge / 60" | bc)
    minutes_remainder=$(echo "$get_minutes_on_charge % 60" | bc)

    printf "Minutes on Charge: %i min (%02iH:%02iM)" $get_minutes_on_charge $hours_on_charge $minutes_remainder
}

# pushes buffer to end of history log
function end_record() {

    cycle_end_percent=

    if [[ $(battery_topped_up) -eq 1 ]]; then

        cycle_end_percent=0
    else
        cycle_end_percent=$(current_capacity)
    fi

    sed -in "$ s/^\(.*\)$/\1 $cycle_end_percent/" $LOG_FILE_PATH
}

# starts new record for fresh battery cycle
function start_new_record() {

    end_record
    echo "0 $(/usr/local/bin/batteryHealth.sh | cut -f1 -d ' ' | tr -d %) $(current_capacity)" >> $LOG_FILE_PATH
}

check_log_file_exists

# cli params
while getopts "dil:r" option; do

    case ${option} in

    d)
        minutes_on_charge_formatted
        exit
        ;;
        
    i)
        if [[ $(battery_topped_up) -eq 1 && $(battery_charging) -eq 0 && ($(minutes_on_charge) -gt 30 || \
        $(uptime | tr -s [:space:] | cut -f4 -d ' ' | tr -d , | cut -f 2 -d :) -lt 2) ]]; then
            start_new_record
            exit
        #elif [[ $(battery_charging) -eq 1 ]]; then
        #   end_record
        else
            update_minutes_on_charge
            exit
        fi
        ;;

    l)
        cat $LOG_FILE_PATH | tail -n $OPTARG
        ;;

    r)
        start_new_record
        ;;

    *)
        echo "invalid option ${option}"
        exit 1
        ;;
    esac

done
