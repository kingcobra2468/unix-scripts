#!/bin/bash
nmap -p 80 73.241.4.93 > /dev/null
if [[ $? -ge 1 ]];
    then
        echo "offline"
        exit
fi
for file in "$@";
    do
        echo $file
        curl --form "image=@$file" http://73.241.4.93/upload.php
done
