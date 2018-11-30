#!/bin/bash
declare -g tasks=()
declare -g taskFile="$HOME/.tasks"

function getTask(){ 
    while read -r line;
        do
            tasks[${#tasks[@]}]=$line
    done < $taskFile
}
function readTask(){
    i=1
    echo -e "\nTasks \t\t $(date)"
    printf "%0.s—" {1..45}
    for task in $(seq 0 $((${#tasks[@]} -1 ))); 
        do
            printf "\n\t[%i] - %s\n" $i "${tasks[$task]}"
            i=$((i+1))
    done
    echo -e "\n"
}


getTask

if [[ $1 == "-a" ]] || [[ $1 == "-d" ]];
    then
        option=$(echo $1 | tr -d -)
        shift
    elif [[ -z $1 ]];
        then
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
    *)       
    ;;
esac 




