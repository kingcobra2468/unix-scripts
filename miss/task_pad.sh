#!/bin/bash

# CLI task manager

declare -g tasks=()
declare -g taskFile="$HOME/.tasks"

function getTask(){ 
    
    while read -r line; do
        tasks[${#tasks[@]}]=$line
    done < $taskFile
}
function readTask(){
    
    i=1
    echo -e "\nTasks \t\t $(date)"
    printf "%0.s—" {1..45}
    for task in $(seq 0 $((${#tasks[@]} -1 ))); do
        printf "\n    [%i] - %s\n" $i "${tasks[$task]}"
        i=$((i+1))
    done
    echo -e "\n"
}

getTask

if [[ $1 == "-a" ]] || [[ $1 == "-d" ]] || [[ $1 == "-m" ]]; then
    option=$(echo $1 | tr -d -)
    shift
elif [[ -z $1 ]]; then
    readTask
else
    echo "Invalid Arg"
    exit
fi

case $option in
    a) #add
        t="$@"
        echo $t >> $taskFile
        exit
        ;;
    d) #remove
        t="$@"
        sed -i "$t{d}" "$taskFile"
        exit
    ;;
    m) #move task to a different num
        if [[ "$#" -eq 2 ]]; then
            
            line=$(awk -v where=$1 '{if(NR==where){line="print"; print $line;}}' $taskFile)
            sed -i "$1{d}" "$taskFile" 
            
            if [[ $2 -gt $(wc -l < $taskFile) ]]; then 
                sed -i "\$a $2i$line" "$taskFile"
            else
                sed -i "$2i/ $line" "$taskFile"
            fi
            
            exit
        else
            echo "Missing source task and destination task"
            exit
        fi
    ;;
esac 