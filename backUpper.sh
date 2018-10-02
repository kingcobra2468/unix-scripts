#!/bin/bash

day=$(date +%d)
month=$(date +%B)
year=$(date +%Y)
date="$day.$month.$year"
backup="$date.BackUp.X201"
serverBackUpDirect="/home/erik/BackUps/$month/$backup"
server.sh -r -u " ~/Documents/Programming " -p $serverBackUpDirect 
