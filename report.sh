#!/bin/bash
clear
echo "Date and time: $(date)"
echo "Current User Name: $(uname)"
echo "hostname: $(hostname)"
external_ip=$(curl -s ifconfig.co)
echo "External IP address: $external_ip"
internal_ip=$(ipconfig getifaddr en0)  # Change 'en0' to the appropriate interface name if needed
echo "Internal IP address: $internal_ip"
echo -e "Name and version of Linux distribution:\n $(sw_vers)"
echo "uptime: $(uptime)"
echo "information about used and free space in / in GB: $(df -H / | awk 'NR==2 {print "Used:", $3, "Free:", $4}')"
# Get total RAM
total_ram=$(sysctl -n hw.memsize)
total_ram_gb=$((total_ram / 1024 / 1024 / 1024))
echo "Total RAM: $total_ram_gb GB"
#Get free RAM
free_ram=$(vm_stat | awk '/Pages free/ {print $3 * 4096 / 1024 / 1024}')
echo "Free RAM: $free_ram MB"
# Get number of CPU cores
num_cores=$(sysctl -n hw.ncpu)
echo "Number of CPU cores: $num_cores"
# Get frequency of CPU cores
echo "Frequency of CPU cores:"
sysctl -n machdep.cpu.brand_string
