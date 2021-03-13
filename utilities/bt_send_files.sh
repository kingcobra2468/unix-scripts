#!/bin/bash

MAC=$(bt-device -l | grep OnePlus | cut -f3 -d ' ')
MAC=${MAC#(}
MAC=${MAC%)}

echo $MAC
echo "$@"

# send files to device over bluetooth
bluetooth-sendto --device=$MAC "$@"

exit