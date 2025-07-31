#!/bin/bash
# Print formatted help message from Makefile target comments
# Usage: print-help.sh [makefile_path]

makefile_path="${1:-Makefile}"

if [ ! -f "$makefile_path" ]; then
    echo "Error: Makefile not found at $makefile_path"
    exit 1
fi

echo "\nAvailable targets:"
# Extract targets with comments after ##
grep -E '^[a-zA-Z_-]+:.*?## .*$$' "$makefile_path" | \
    awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

echo "\nRun 'make <target>' to execute a specific target."
echo "Run 'make help' to see this message again.\n"
