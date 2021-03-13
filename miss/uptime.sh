#!/bin/bash

# Formatter for system uptime

time_delta=$(cat /proc/uptime | cut -f1 -d ' ' )
time_delta=${time_delta%.*}

echo "$((time_delta / 3600))H:$(((time_delta % 3600)/60))M"