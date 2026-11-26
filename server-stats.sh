#!/usr/bin/bash
# Description: Fetches basic server statistics

cpu_top_line=$(top -b -n 1|grep Cpu)
cut_grab_id=$(cut -d "," -f 4 <<<"$cpu_top_line")
cut_grab_number=$(cut -d " " -f 1 <<<"$cut_grab_id")
cpu_usage=$(printf "100.0 - %s\n" "$cut_grab_number"|bc)
echo "total cpu usage: $cpu_usage"
