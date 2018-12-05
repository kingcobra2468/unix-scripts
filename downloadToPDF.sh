#!/bin/bash

for url in "$@";
    do
    ping -qc 1 $(echo $url | tr -s '/' | cut -f2 -d '/') > /tmp/1
    if [[ $? -eq 0 ]];
        then
            title=$(echo "$url" | tr -s '/' ' ' | awk -F' ' '{print $NF}')
            wkhtmltopdf -q $url "$PWD/$title.pdf"
    fi
done



