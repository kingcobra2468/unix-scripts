#!/bin/bash

file=$1
field=$2
pwd=$(pwd)
file="$pwd/$file"
x=$( cat $file | tr -s [:blank:] " " | cut -f${field} -d' ') 

for element in $x; do
	element="\"$element\","
	running=$running$element
done

echo $running