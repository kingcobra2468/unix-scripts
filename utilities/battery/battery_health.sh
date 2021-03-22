#!/bin/bash

# script records the battery degregation of the laptop given the original battery spec

declare -g health=0

function printDegregation(){
    printf "%.2f%% Degregation. Battery condition %s\n" $1 $2
}

if [[ -e /sys/class/power_supply/BAT0/charge_full ]]; then

    health=$(echo $(cat /sys/class/power_supply/BAT0/charge_full) / $(cat /sys/class/power_supply/BAT0/charge_full_design) | bc -l)
elif [[ -e /sys/class/power_supply/BAT0/energy_full ]]; then

    health=$(echo $(cat /sys/class/power_supply/BAT0/energy_full) / $(cat /sys/class/power_supply/BAT0/energy_full_design) | bc -l)
fi

health=$(echo "$health*100" | bc)

if [[ $(echo $health'>='90 | bc -l) -eq 1 ]]; then
        printDegregation $health "Great"

elif [[ $(echo $health'>='70 | bc -l) -eq 1 ]]; then
        printDegregation $health "Good"

elif [[ $(echo $health'>='50 | bc -l) -eq 1 ]]; then
        printDegregation $health "Fair"

elif [[ $(echo $health'>='20 | bc -l) -eq 1 ]]; then
        printDegregation $health "Bad"
else
    printDegregation $heath "Very Bad"
fi
