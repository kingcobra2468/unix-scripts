#!/bin/bash

i=0

until [[ $i -ge 255 ]]; do 
    
    fping -q -t 1 10.0.1.$i > /tmp/junk
    x=$?

    if [ $x -eq 0 ]; then
        echo "Local Adress Found: 10.0.1.$i"
    fi\

    ((i+=1))
done