#!/bin/zsh

file="bar.txt"

if find "$file" -type f >/dev/null
then
    echo "$file file found"
else
    echo "created by bash" | cat >> "$file"
fi
