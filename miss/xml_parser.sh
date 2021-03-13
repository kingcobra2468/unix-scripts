#!/bin/bash

function helpInfo(){
    echo -e "SUPPORTED FLAGS
    -f {xml source file} 
    -t {xml tag to parse}
    -e {embed xml value ex:('\"\1\",') to embed in double qoutes with trailing comma} "
}

while getopts "e:f:t:o:?" option; do
    case $option in
        f)
            file=$OPTARG
            ${embed:="\1"}
        ;;
        t)
            tag=$OPTARG
        ;;
        e)
            embed=$OPTARG
        ;;
        o)
        ;;
        ?)
        helpInfo
        exit
        ;;
    esac
done

if [[ -z $file ]] || [[ -z $tag ]]; then
    echo -n "INPUT ERROR - "
    helpInfo
else
    cat $file | grep -oE "<$tag>(.){0,30}</$tag>" | sed -e "s/.*<$tag>\(.*\)<\/$tag>.*/$embed/"
fi

# Example run
# -----------
# ./XMLparser.sh -f ~/output -t Key -e '"\1",'
# "UNFINISHED_NOTES.mp3",
# "VEIN_MAPPING.mp3",
# "XRAY.mp3",