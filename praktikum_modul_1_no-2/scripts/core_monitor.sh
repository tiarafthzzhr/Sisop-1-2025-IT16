#!/bin/bash
#top -bn1 | grep "Cpu(s)" | \
#           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
#           awk '{print 100 - $1"%"}'

#echo "Cpu usage : " && grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'
#echo "For the further information"
#mpstat | grep -A 5 "%idle" | tail -n 1 | awk -F " " '{print 100 -  $ 12}'a
#mpstat | awk '$3 ~ /CPU/ { for(i=1;i<=NF;i++) { if ($i ~ /%idle/) field=i } } $3 ~ /all/ { print 100 - $field }'
#mpstat 
LOG_FILE="/home/kali/sisop/praktikum_modul_1/logs/core.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
RAM_USED=$(free -m | awk '/Mem:/ {print $3}')
RAM_AVAILABLE=$(free -m | awk '/Mem:/ {print $7}')
RAM_USAGE=$(awk "BEGIN {printf \"%.2f\", ($RAM_USED/$RAM_TOTAL)*100}")

echo "[$TIMESTAMP] - Fragment Usage [$RAM_USAGE%] - Fragment Count [$RAM_USED MB] - Details [Total: $RAM_TOTAL MB, Available: $RAM_AVAILABLE MB]" >> "$LOG_FILE"
