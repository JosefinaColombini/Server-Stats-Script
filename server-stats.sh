#!/usr/bin/bash
# Description: Fetches basic server statistics

cpu_top_line=$(top -b -n 1|grep Cpu)
cut_grab_id=$(cut -d "," -f 4 <<<"$cpu_top_line")
awk '{print "total cpu usage: " 100-$1 "%"}' <<<"$cut_grab_id"

mem_total=$(cat /proc/meminfo | grep "MemTotal:" | awk '{print $2}')
mem_available=$(cat /proc/meminfo | grep "MemAvailable:" | awk '{print $2}')
mem_available_mb=$(bc <<< "$mem_available/1000")
mem_available_per=$(($mem_available*100/$mem_total))
mem_used=$(($mem_total-$mem_available))
mem_usage_per=$((100-$mem_available_per))
mem_used_mb=$(bc "$mem_used/1000")
echo "total memory used: $mem_used_mb ($mem_usage_per %)"
echo "total memory free: $mem_available_mb ($mem_available_per %)"
