#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 [-v] [-s <A_WORD> <B_WORD>] [-r] [-l] [-u] -i <input_file> -o <output_file>"
    echo "-v: Swap case (convert lowercase to uppercase and vice versa)"
    echo "-s <A_WORD> <B_WORD>: Substitute A_WORD with B_WORD (case sensitive)"
    echo "-r: Reverse text lines"
    echo "-l: Convert text to lowercase"
    echo "-u: Convert text to uppercase"
    echo "-i <input_file>: Specify input file"
    echo "-o <output_file>: Specify output file"
    exit 1
}

# Variables to store options' arguments
_swap_case=false
_substitute=""
_reverse=false
_to_lower=false
_to_upper=false
_input_file=""
_output_file=""

# Parsing options
while getopts ":vs:rlui:o:" opt; do
    case ${opt} in
        v)
            _swap_case=true
            echo "Swap case option detected."
            ;;
        s)
            _substitute="$OPTARG"
            echo "Substitute option detected. Arguments: $OPTARG"
            ;;
        r)
            _reverse=true
            echo "Reverse option detected."
            ;;
        l)
            _to_lower=true
            echo "Convert to lowercase option detected."
            ;;
        u)
            _to_upper=true
            echo "Convert to uppercase option detected."
            ;;
        i)
            _input_file="$OPTARG"
            echo "Input file option detected. Argument: $OPTARG"
            ;;
        o)
            _output_file="$OPTARG"
            echo "Output file option detected. Argument: $OPTARG"
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

# Check if mandatory options are provided
if [ -z "$_input_file" ] || [ -z "$_output_file" ]; then
    echo "Input and output files are required." 1>&2
    usage
fi

# Read input file
if [ ! -f "$_input_file" ]; then
    echo "Input file '$_input_file' not found." 1>&2
    usage
fi
text=$(<"$_input_file")

# Swap case
if $_swap_case; then
    swapped_text=""
    for (( i=0; i<${#text}; i++ )); do
        char="${text:i:1}"
        if [[ "$char" == [[:lower:]] ]]; then
            char="$(tr '[:lower:]' '[:upper:]' <<<"$char")"
        elif [[ "$char" == [[:upper:]] ]]; then
            char="$(tr '[:upper:]' '[:lower:]' <<<"$char")"
        fi
        swapped_text+="$char"
    done
    text="$swapped_text"
fi

# Substitute words
if [ -n "$_substitute" ]; then
    old_word=$(echo "$_substitute" | awk '{print $1}')
    new_word=$(echo "$_substitute" | awk '{print $2}')
    text=$(echo "$text" | sed "s/$old_word/$new_word/g")
fi

# Reverse text lines
if $_reverse; then
    text=$(echo "$text" | awk '{ lines[NR] = $0 } END { for (i=NR; i>=1; i--) print lines[i] }')
fi

# Convert text to lowercase
if $_to_lower; then
    text=$(echo "$text" | tr '[:upper:]' '[:lower:]')
fi

# Convert text to uppercase
if $_to_upper; then
    text=$(echo "$text" | tr '[:lower:]' '[:upper:]')
fi

# Write output to file
echo "$text" > "$_output_file"

echo "Output written to $_output_file"

