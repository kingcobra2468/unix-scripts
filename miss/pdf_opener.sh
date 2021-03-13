#!/bin/bash

# script lists pdfs on a system with options to add, remove, and delete

path="/home/erik/Documents/dontUpdate/PDFs/" #path of your pdfs

declare -g choices=()
declare -g pdfId= #used for renaming

function saveToArray() {
    
    choices=()
    
    for arg in $(ls $path); do 
        choices[${#choices[@]}]="[$( printf "%02d" $((${#choices[@]}+1)))] $arg"
    done
}

function organizedPrint(){
    
    for i in $(seq 0 2 ${#choices[@]}); do
        awk -vone="${choices[$i]}" -vtwo="${choices[$((i+1))]} \
            " 'BEGIN { printf "%-50.45s %-50.45s\n", one, two}'
    done
}   

saveToArray

while getopts "lo:i:r:d:?" option; do
    
    case $option in
    l)
        organizedPrint
        ;;
    o)
        if [[ $OPTARG -le ${#choices[@]} ]]; then
            evince $path$(echo ${choices[$(($OPTARG-1))]} | cut -f2 -d ' ') &
        elif [[ $OPTARG -gt ${#choices[@]} ]]; then
                echo "Out of Scope"
                exit
        else
            evince $path$OPTARG &
            exit
        fi
        ;;
    i)
        pdfId=$OPTARG
        ;;
    d)
        file=$( echo ${choices[$(($OPTARG-1))]} | cut -f 2 -d ' ')
        if [[ -e $path$file ]]; then
            rm $path$file
        fi

        exit
        ;;
    r)
        if [[ -z $pdfId ]]; then
            echo "pdf id ( -i arg) not selected"
            exit
        fi

        file=$(echo ${choices[$(($pdfId-1))]} | cut -f 2 -d ' ')
        mv $path$file $path$OPTARG
        
        exit
        ;;
    ?)
        echo -e "\t-l list\n\t-d delete\n\t-o open\n\t-i id\n\t-r rename"
        exit
    ;;
    esac
done

organizedPrint   