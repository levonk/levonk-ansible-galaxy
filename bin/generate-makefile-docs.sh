#!/bin/bash
# Generate documentation for Makefile targets
# Usage: generate-makefile-docs.sh [makefile_path] [output_file]
#
# This script generates:
# 1. A hierarchical list of Makefile targets with descriptions
# 2. A mermaid dependency diagram showing target relationships

makefile_path="${1:-Makefile}"
output_file="${2:-/dev/stdout}"

if [ ! -f "$makefile_path" ]; then
    echo "Error: Makefile not found at $makefile_path"
    exit 1
fi

# Extract target dependencies from Makefile
extract_dependencies() {
    local makefile=$1
    local deps_file=$(mktemp)
    
    # Extract target dependencies
    awk '/^[a-zA-Z0-9_-]+:/ {
        target=$0;
        sub(/:.*/, "", target);
        deps=$0;
        sub(/[^:]*:/, "", deps);
        sub(/\\.*/, "", deps);
        sub(/#.*/, "", deps);
        gsub(/[ \t]+/, " ", deps);
        if (deps != "") {
            split(deps, dep_array, " ");
            for (i in dep_array) {
                if (dep_array[i] != "") {
                    print target "->" dep_array[i];
                }
            }
        }
    }' "$makefile" | sort | uniq > "$deps_file"
    
    echo "$deps_file"
}

# Function to generate a hierarchical section of the documentation
generate_hierarchical_section() {
    local title=$1
    local pattern=$2
    local exclude_pattern=${3:-'^$'}
    local indent=${4:-0}
    local prefix=""
    
    for ((i=0; i<indent; i++)); do
        prefix="$prefix  "
    done
    
    echo -e "\n### $title\n"
    
    grep -E '^[a-zA-Z_-]+:.*?## .*$' "$makefile_path" | \
        grep -E "$pattern" | \
        grep -vE "$exclude_pattern" | \
        sort | \
        awk -v prefix="$prefix" 'BEGIN {FS = ":.*?## "}; {printf "%s- `%s`: %s\n", prefix, $1, $2}'
}

# Start generating the markdown
cat > "$output_file" << 'EOF'
# Makefile Documentation

This project uses a Makefile to automate common development tasks. The targets are organized hierarchically below.

## Target Hierarchy
EOF

# Generate hierarchical sections

# First, get all targets with descriptions
targets_file=$(mktemp)
grep -E '^[a-zA-Z_-]+:.*?## .*$' "$makefile_path" | sort > "$targets_file"

# Build & Test Targets
echo -e "\n### Build & Test Targets\n" >> "$output_file"
grep -E '^all:|^build:|^test:|^clean:|^archive:|^format:' "$targets_file" | \
    awk 'BEGIN {FS = ":.*?## "}; {printf "- `%s`: %s\n", $1, $2}' >> "$output_file"

# Lint Targets
echo -e "\n### Lint Targets\n" >> "$output_file"
grep -E '^lint:|^lint-' "$targets_file" | \
    awk 'BEGIN {FS = ":.*?## "}; {printf "- `%s`: %s\n", $1, $2}' >> "$output_file"

# Installation Targets
echo -e "\n### Installation Targets\n" >> "$output_file"
grep -E '^install' "$targets_file" | \
    awk 'BEGIN {FS = ":.*?## "}; {printf "- `%s`: %s\n", $1, $2}' >> "$output_file"

# Documentation Targets
echo -e "\n### Documentation Targets\n" >> "$output_file"
grep -E '^docs:|^help:|^usage:' "$targets_file" | \
    awk 'BEGIN {FS = ":.*?## "}; {printf "- `%s`: %s\n", $1, $2}' >> "$output_file"

# Utility Targets
echo -e "\n### Utility Targets\n" >> "$output_file"
grep -E '^version:|^status:' "$targets_file" | \
    awk 'BEGIN {FS = ":.*?## "}; {printf "- `%s`: %s\n", $1, $2}' >> "$output_file"

# Clean up
rm -f "$targets_file"

# Generate mermaid diagram
deps_file=$(extract_dependencies "$makefile_path")

cat >> "$output_file" << 'EOF'

## Target Dependencies

The following diagram shows the dependencies between Makefile targets:

```mermaid
graph TD
EOF

# Add the dependencies to the mermaid diagram
cat "$deps_file" >> "$output_file"

# Close the mermaid diagram
echo '```' >> "$output_file"

# Clean up
rm -f "$deps_file"

# Add a section about how to use the Makefile
cat >> "$output_file" << 'EOF'

## Using the Makefile

To use the Makefile, run `make <target>` where `<target>` is one of the targets listed above.

For example:

```bash
# Show help
make help

# Build the project
make build

# Run all linting tools
make lint

# Run a specific linting tool
make lint-ansible
```

Running `make` without a target will show the help message and then build the project.
EOF

echo "Documentation generated in $output_file"

# If the output is not stdout, print a message about updating README.md
if [ "$output_file" != "/dev/stdout" ]; then
    echo "To update the README.md with this documentation, you can use:"
    echo "  sed -i '/^## Makefile/,/^## /d' README.md && sed -i '/^# Makefile/r $output_file' README.md"
fi
