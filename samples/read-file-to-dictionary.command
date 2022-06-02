#!/bin/zsh

count=0
declare -A dict
file="foo-dictionary.txt"

echo "Reading file script"

while IFS= read -r line || [[ -n "$line" ]]; do
    # Add each line to a dictionary
    key=$(echo $line | cut -d "|" -f1)
    value=$(echo $line | cut -d "|" -f2)
    dict[$key]=$value
    # Print option
    count=$((count+1))
    echo "Dictionary value of $key : $value"
done < "$file"

echo "Dictionary values read from file: ${dict[@]}"