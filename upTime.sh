x=$(cat /proc/uptime | cut -f1 -d ' ' )
x=${x%.*}
echo "$((x / 3600))H:$(((x % 3600)/60))M"