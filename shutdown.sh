#!/bin/bash

function testUp(){
    nc -w 1  -z $1 22
    if [[ $? -eq 1 ]];
            then
                return 1
    else
        return 0
    fi
}



ips=('10.0.1.10' '10.0.1.97')
while getopts "abs" option;
    do

    case $option in
        a) #all
            for ip in ${ips[@]};
            do
                if [[ $(testUp $ip) -eq 0 ]];
                then
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
            for ip in ${ips[@]};
            do
               ssh -t erik@$ip sudo shutdown -P now
               shift 
            done
        ;;
        *)
            echo "Invalid Input"
        ;;
    esac 
done

