#!/bin/bash

# device name is the 1st arg
DEVICE_NAME=$1
# youtube links are the 2nd .. nth args
LINKS=${@:2}

# fetch MAC address of a paired device
function device_mac() {
    mac=$(bt-device -l | grep $1 | grep -oE "([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}")
    echo $mac
}

if [[ -z $DEVICE_NAME ]]; then
    echo "DEVICE_NAME, the first argument, is not set"
    exit 1
fi

device_mac=$(device_mac $DEVICE_NAME)
dump_dir=$(mktemp -d)

pushd $dump_dir
youtube-dl --extract-audio --audio-format mp3 $LINKS
# if any mp3s downloaded, then transfer to device
if [[ $(ls | egrep -E '*.mp3' | wc -l) -gt 0 ]]; then
    for mp3 in *.mp3; do
        bt-obex -p $device_mac "$mp3"
    done 
fi
popd

rm -fr $dump_dir
exit