#!/bin/bash

start=$(date +%s.%N)
day=$(date +%d)
month=$(date +%B)
year=$(date +%Y)

date="$day.$month.$year"

backup="$date.BackUp.Desktop"
serverBackUpDir="/home/erik/BackUps/$year/$month/"

if [[ -e "/tmp/$backup.tar" ]]; then
    rm "/tmp/$backup.tar"
fi

tar -C /home/erik/Documents/ -czf "/tmp/$backup.tar" ~/Documents/Programming/* $@

scp "/tmp/$backup.tar" erik@10.0.1.10:$serverBackUpDir

end=$(date +%s.%N)
lapse=$(echo $end-$start | bc -l )
echo "Completed: $lapse seconds"
