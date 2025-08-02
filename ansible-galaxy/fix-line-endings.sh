#!/bin/bash

# Find all files with CRLF line endings and convert them to LF
echo "Fixing line endings in all files..."

# Find all files and convert their line endings
find . -type f -not -path "./.git/*" -not -path "./venv/*" -not -path "./tests/output/*" \
    -exec file {} \; | grep "CRLF" | cut -d: -f1 | while read -r file; do
    echo "Fixing line endings in $file"
    # Convert CRLF to LF
    sed -i 's/\r$//' "$file"
done

echo "Line endings have been fixed."
