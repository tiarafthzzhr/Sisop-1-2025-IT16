#free -t | printf '%Ram usage : ' && awk 'FNR == 2 {printf("%.2f%"), $3/$2*100}' 

#watch -n 5 "/usr/bin/top -b | head -4 | tail -2 | perl -anlE 'say sprintf(\"used: %s   total: %s  => RAM Usage: %.1f%%\", \$F[7], \$F[3], 100*\$F[7]/\$F[3]) if /KiB Mem/'"

#watch   '/usr/bin/top -b | head -4 | tail -2'
#top -bn2 | grep '%Cpu' | tail -1 | grep -P '(....|...) id,' | awk '{print 100-$8 "%"}'


#echo "--------------------------------------"
#cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (t>0) print (u*100/t)}' /proc/stat | head -n 1)
#echo "CPU Usage: ${cpu_usage}%"

# Menghitung penggunaan RAM (tanpa bc, hanya integer)
#mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
#mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
#mem_used=$((mem_total - mem_available))
#ram_usage=$((mem_used * 100 / mem_total))  # Hanya bilangan bulat
#echo "RAM Usage: ${ram_usage}%"
#echo "--------------------------------------"


#!/bin/bash

LOG_FILE="/home/kali/sisop/praktikum_modul_1/logs/fragment.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
RAM_USED=$(free -m | awk '/Mem:/ {print $3}')
RAM_AVAILABLE=$(free -m | awk '/Mem:/ {print $7}')
RAM_USAGE=$(awk "BEGIN {printf \"%.2f\", ($RAM_USED/$RAM_TOTAL)*100}")

echo "[$TIMESTAMP] - Fragment Usage [$RAM_USAGE%] - Fragment Count [$RAM_USED MB] - Details [Total: $RAM_TOTAL MB, Available: $RAM_AVAILABLE MB]" >> "$LOG_FILE"

