#!/bin/bash

while [[ $(ssh erik@67.170.205.141 "cat ~/.executeCommand") != "TERMINATE" ]];
do
    ping -c 1 67.170.205.141 > /tmp/crap
    if [[ $? -eq 0 ]];
        then
            eval $(ssh erik@67.170.205.141 "cat ~/.executeCommand; echo '' > ~/.executeCommand")
            sleep 10
        else
            sleep 60
    fi
done
#rm $0