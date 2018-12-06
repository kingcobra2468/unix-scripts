#!/bin/bash

flag=$1
shift


for url in "$@";
    do
    ping -qc 1 $(echo $url | tr -s '/' | cut -f2 -d '/') > /tmp/1
    if [[ $? -eq 0 ]];
        then
            title=$(echo "$url" | tr -s '/' ' ' | awk -F' ' '{print $NF}')
            case $flag in
                '-s')
                    wkhtmltopdf -q $url "/tmp/$title.pdf"
                    ;;
                '-d')
                    wkhtmltopdf $url "$PWD/$title.pdf"
                    ;;
                *)
                    wkhtmltopdf -q $url "/tmp/$title.pdf"
            esac
    fi
done

if [[ $flag == '-s' ]];
    then
    bash sendOverBT.sh /tmp/*.pdf
fi


