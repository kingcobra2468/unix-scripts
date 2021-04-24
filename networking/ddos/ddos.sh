#!/bin/bash

# Note to stop run : sudo killall ping

i=0
while [[ $i -lt 10 ]]; do
    . ./d22.sh &
    i=$((i+1))
done