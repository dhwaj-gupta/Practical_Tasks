#!/bin/bash

# Declare variables
declare -i A=0
declare -i B=1
declare -i C=1
declare -i it=3

# Function to calculate Fibonacci sequence
fib() {
    if [ "$1" -eq 0 ]; then
        echo "$A"
    elif [ "$1" -eq 1 ]; then
        echo "$B"
    else
        while [ "$it" -le "$1" ]; do
            C=$((A + B))
            A="$B"
            B="$C"
            ((it++))
        done
        echo "$C"
    fi
}

# Main program
echo "Enter value of n:"
read -r n
result=$(fib "$n")
echo "Fibonacci sequence at position $n is: $result"

