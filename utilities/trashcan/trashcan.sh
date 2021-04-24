#!/bin/bash

trashPath="~/Documents/Trash"

while getopts "r:" option; do
    case ${option} in 
        r)
        command="mv -f "
        ;;
    esac
done

if [[ -z $command ]]; then
    command="mv "
else
    shift #to get rid of the -r flag if it exists
fi

command+="$@ $trashPath"
eval $command