#!/bin/bash

# script to fix bug when wifi card not detected. Install necessary drivers

#wifi activator script Restart computer with ETHERNET turned off
sudo apt-get install linux-headers-generic
sudo apt-get install --reinstall bcmwl-kernel-source
#shutdown -P now