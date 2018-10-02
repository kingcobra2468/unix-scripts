#!/bin/bash


nc -w 1  -z 67.170.205.141 22
if [[ $? -eq 1 ]];
    then
        shutdown -P now

else
    backUpper.sh
    shutodwn -P now
fi