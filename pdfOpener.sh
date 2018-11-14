#!/bin/bash
path="/home/erik/Documents/Programming/PDFs/" #path of your pdfs
declare -g choices=()
function saveToArray(){
    choices=()
    for arg in $(ls $path);
        do 
            choices[${#choices[@]}]="[$((${#choices[@]}+1))] $arg"
    done
}

function organizedPrint(){
    for i in $(seq 0 2 ${#choices[@]});
    do
        awk -vone="${choices[$i]}" -vtwo="${choices[$((i+1))]}" 'BEGIN { printf "%-50s %-50s\n", one, two}'
    done
}   

saveToArray

while getopts "lo:" option;
    do
    case $option in
    l)
        organizedPrint
        ;;
    o)
        case $OPTARG in
            [0-${#choices[@]}])
                evince $path$(echo ${choices[$userArg]} | cut -f2 -d ' ')
                ;;
            *)
            if [[ $OPTARG -gt ${#choices[@]} ]];
                then
                    echo "Out of Scope"
                    exit
            
            else
                evince $path$OPTARG
            fi
            ;;
        esac
    esac
done


    
    