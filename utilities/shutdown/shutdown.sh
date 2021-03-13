#!/bin/bash

# Automation for network wide shutoff. Shutdown services

# services which prevent system from shutting down
priorityServiers=("skypeforlinux" "discord")

for service in $priorityServiers; do 
    if [[ $(ps -ef | egrep "$service" | wc -l) ]]; then
        killall $service 
    fi
done

function testUp(){
    ping -c 1 $1 > /dev/null
    if [[ $? -eq 1 ]];then
        echo 1
    else
        echo 0
    fi
}

ips=('10.0.1.10' '10.0.1.97')
while getopts "absRoc:" option; do    
    case $option in
        a) #all
            for ip in ${ips[@]}; do
                if [[ $(testUp $ip) -eq 0 ]]; then
                    ssh -t erik@$ip sudo shutdown -P now
                fi
                shift
            done
            shutdown -P now
        ;;
        b)     #backup
            if [[ $(testUp "10.0.1.10") -eq 1 ]];
            then
                shutdown -P now
            else
                backUpper.sh
                shutdown -P now
            fi
        ;;

        s) #servers
            for ip in ${ips[@]}; do
                if [[ $(testUp $ip) -eq 0 ]]; then
                    ssh -t erik@$ip sudo shutdown -P now
                fi
                shift
            done
        ;;
        R)
            shutdown -r now
        ;;
        o)
            shutdown -P now
        ;;
        c)
            for ip in $OPTARG;do
                if [[ $(testUp ${ip#*@}) -eq 0 ]]; then
                    ssh -t $ip sudo shutdown -P now
                fi
            done
        ;;
        *)
            echo "Invalid Input"
        ;;
    esac 
done