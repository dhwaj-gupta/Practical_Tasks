#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 -s <shift> -i <input_file> -o <output_file>"
    echo "-s <shift>: Specify the shift value"
    echo "-i <input_file>: Specify input file"
    echo "-o <output_file>: Specify output file"
    exit 1
}

# Variables to store options' arguments
shift_value=""
input_file=""
output_file=""

# Parsing options
while getopts ":s:i:o:" opt; do
    case ${opt} in
        s)
            shift_value=$OPTARG
            ;;
        i)
            input_file=$OPTARG
            ;;
        o)
            output_file=$OPTARG
            ;;
        \?)
            echo "Invalid option: $OPTARG" 1>&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if mandatory options are provided
if [ -z "$shift_value" ] || [ -z "$input_file" ] || [ -z "$output_file" ]; then
    echo "Shift value, input file, and output file are required." 1>&2
    usage
fi

# Function to perform Caesar cipher
caesar_cipher() {
    local input_text="$1"
    local shift="$2"
    local output=""

    for ((i = 0; i < ${#input_text}; i++)); do
        char="${input_text:$i:1}"
        if [[ "$char" =~ [A-Za-z] ]]; then
            ascii_val=$(printf "%d" "'$char" 2>/dev/null)
            if [[ "$char" =~ [A-Z] ]]; then
                ascii_val=$((ascii_val - 65))
                ascii_val=$((ascii_val + shift))
                ascii_val=$((ascii_val % 26))
                ascii_val=$((ascii_val + 65))
            else
                ascii_val=$((ascii_val - 97))
                ascii_val=$((ascii_val + shift))
                ascii_val=$((ascii_val % 26))
                ascii_val=$((ascii_val + 97))
            fi
            char=$(printf "\\$(printf '%03o' "$ascii_val")")
        fi
        output+="$char"
    done

    echo "$output"
}

# Read input file
input_text=$(<"$input_file")

# Perform Caesar cipher
output_text=$(caesar_cipher "$input_text" "$shift_value")

# Write output to file
echo "$output_text" > "$output_file"

echo "Output written to $output_file"

