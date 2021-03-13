#!/bin/bash

shopt -s expand_aliases

while getopts "cp" option; 
    do
        case $option in
            c)
                commandString=
                for string in ${@:2};
                    do
                        commandString+="$string "
                done
                echo "$( eval $commandString)" > ~/.copyPaste
            ;;
        esac
done

