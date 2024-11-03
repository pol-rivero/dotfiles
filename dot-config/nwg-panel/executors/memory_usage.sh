#!/bin/bash

total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
free_mem=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

used_mem=$((total_mem - free_mem))
used_percentage=$(awk "BEGIN {printf \"%.2f\", ($used_mem / $total_mem) * 100}")

printf " %.0f%%\n" $used_percentage
