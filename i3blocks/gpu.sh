#!/bin/bash

# Query GPU utilization, memory usage, and temperature
info=$(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv,noheader,nounits)

# Split output by comma (removing spaces)
gpu_util=$(echo $info | cut -d',' -f1 | xargs)
mem_used=$(echo $info | cut -d',' -f2 | xargs)
mem_total=$(echo $info | cut -d',' -f3 | xargs)
temp=$(echo $info | cut -d',' -f4 | xargs)

# Print nicely formatted output
echo "$gpu_util%   ${mem_used}MiB   ${mem_total}MiB   ${temp}°C"
