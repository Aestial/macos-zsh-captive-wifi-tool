#!/bin/zsh

count=0
declare -a array
file="foo-array.txt"

echo "Reading file script"

while IFS= read -r line || [[ -n "$line" ]]; do
    # Add each line to an array
    value=$(echo $line)
    array+=("$value")
    # Print option
    count=$((count+1))
    echo "Array value $count : $line"
done < "$file"

echo "Array read from file: ${array[@]}"