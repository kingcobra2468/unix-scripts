#!/bin/bash

start=$(date +%s.%N)
day=$(date +%d)
month=$(date +%B)
year=$(date +%Y)
date="$day.$month.$year"
backup="$date.BackUp.Desktop"
serverBackUpDirect="/home/erik/BackUps/$month/$backup.tar"
tar -czf /tmp/testa.tar ~/Documents/Programming/*
server.sh -u "/tmp/testa.tar" -p $serverBackUpDirect
end=$(date +%s.%N)
end=$(echo $end-$start | bc -l )
echo "Completed: $end seconds"
