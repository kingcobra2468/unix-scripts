#!/bin/bash

# calculates the percentage of the day that has elapsed
printf "%.2f%%\n" $(echo "$(echo "$(echo "$(echo "(($(date +%k) + 1)) * 60" | bc) \
    + $(date +%M)" | bc) / 1440" | bc -l) * 100" | bc)