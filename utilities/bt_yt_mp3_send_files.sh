#!/bin/bash

# device name is the 1st arg
device_name=$1
# youtube links are the 2nd .. nth args
links=${@:2}

# fetch MAC address of a paired device
function device_mac() {
    mac=$(bt-device -l | grep $1 | grep -oE "([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}")
    echo $mac
}

if [[ -z $device_name ]]; then
    echo "device_name, the first argument, is not set"
    exit 1
fi

device_mac=$(device_mac $device_name)
dump_dir=$(mktemp -d)

pushd $dump_dir
youtube-dl --extract-audio --audio-format mp3 $links
# if any mp3s downloaded, then transfer to device
if [[ $(ls | egrep -E '*.mp3' | wc -l) -gt 0 ]]; then
    for mp3 in *.mp3; do
        bt-obex -p $device_mac "$mp3"
    done 
fi
popd

rm -fr $dump_dir
exit