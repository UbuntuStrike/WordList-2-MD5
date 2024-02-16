#!/bin/bash

# Check if wordlist is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <wordlist> <output_file>"
    exit 1
fi

wordlist="$1"
output_file="$2"

# Check if wordlist exists
if [ ! -f "$wordlist" ]; then
    echo "Error: Wordlist '$wordlist' not found."
    exit 1
fi

# Check if output file already exists
if [ -f "$output_file" ]; then
    echo "Error: Output file '$output_file' already exists. Please choose a different name."
    exit 1
fi

# Read each line from the wordlist, convert to MD5 hash, and write to output file
while IFS= read -r line; do
    md5_hash=$(echo -n "$line" | md5sum | cut -d ' ' -f 1)
    echo "$md5_hash" >> "$output_file"
done < "$wordlist"

echo "MD5 hashes written to '$output_file'."
