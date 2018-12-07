#!/bin/bash

local="/home/erik/Documents/Programming/Bash/Desktop/"
dirProjectName="AwesomeProject2"
backup=$(ssh erik@DONT_STEAL_MY_IP  -qt "cd ~/APP | ls -l ~/APP | sort -M | tail -n 2 | head -n 1 | tr -s [:space:] | cut -f9 -d ' ' ")
scp -q erik@DONT_STEAL_MY_IP:/home/erik/APP/"${backup}" '/tmp/newOne.tar'
cd /tar
tar --strip-components=2 -zxf '/tmp/newOne.tar' -C '/tmp/' 
diff -rq $local '/tmp/Desktop/' > /tmp/differences

while read -r line;
    do
        if [[ $line == *"Only"* ]];
            then
            echo $line
            echo "Only";
            if [[ $line == *"tmp"* ]];
                then
                    location=$(echo $line | cut -f 3,4 -d ' ' | tr -t ":[:blank:]" '/' | tr -d [:blank:])
                    cp $location "$local$(echo "$location" | egrep -o "*$dirProjectName*\w.+")"
            fi
        elif [[ $line == *"differ"* ]];
            then
                echo $line
                echo $"Differ"
                cp $(echo $line | cut -f4 -d ' ') $(echo $line | cut -f2 -d ' ')
        fi

done < /tmp/differences

clear
echo -e "Up To Date\n"