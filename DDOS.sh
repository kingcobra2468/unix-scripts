#!/bin/bash
i=0
while [[ $i -lt 10 ]]; do
	#sudo ping -f -s 65460 10.0.1.70
	. ~/Documents/Programming/Bash/d22.sh &
	#echo "--------------------------------------------------"
	i=$((i+1))
done



#sudo killall ping
