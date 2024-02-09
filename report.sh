#!/bin/bash
echo "Date and time: $(date)"
echo "User Name: $(uname)"
echo "hostname: $(hostname)"
echo "internal ip address: ip route get 1 | awk '{print $NF;exit}'"
echo "uptime: $(uptime)"
# echo "number of cpu cores: $(~/proc)"
# echo "frequency of cpu cores: $(~/cat/proc/cpuinfo | grep -E "cpu MHz" | awk 'print $4')"
