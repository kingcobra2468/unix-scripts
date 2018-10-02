#!/bin/bash
x=$(ls -l /dev/input/by-path | egrep "*kbd*" | cut -f 11 -d ' ')

echo ${x#"../"}
