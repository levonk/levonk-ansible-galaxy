#!/bin/sh

# Lint YAML files with yamllint

# Source common functions
. "$(dirname "$0")/common.sh"

# Default values
COLLECTIONS_DIR="$(get_collections_dir)"
QUIET="${QUIET:-false}"
VERBOSE="${VERBOSE:-false}"
NO_FAIL="${NO_FAIL:-false}"

# Check if yamllint is installed
if ! command_exists yamllint; then
    warn "yamllint not found. Skipping YAML linting."
    warn "Install with: pip install yamllint"
    exit 0
fi

echo -n "Linting YAML files... "

ERRORS_FOUND=0
for collection in $(get_collections); do
    collection_dir="${COLLECTIONS_DIR}/${collection}"
    
    if [ ! -d "$collection_dir" ]; then
        warn "Collection directory not found: $collection"
        ERRORS_FOUND=1
        continue
    fi

    if is_quiet; then
        # Quiet mode - only show errors
        if ! find "$collection_dir" -name "*.yml" -o -name "*.yaml" -type f -exec yamllint -f parsable {} + > /dev/null 2>&1; then
            echo "${ERROR}"
            echo "Error: YAML linting issues found in $collection. Run with VERBOSE=1 for details."
            ERRORS_FOUND=1
            [ "$NO_FAIL" = "true" ] || exit 1
        fi
    else
        # Verbose mode - show all details
        echo "\n=== Linting YAML files in levonk.${collection} ==="
        if ! find "$collection_dir" -name "*.yml" -o -name "*.yaml" -type f -exec sh -c 'for f; do echo "Checking $f"; yamllint "$f" || exit 1; done' _ {} +; then
            echo "${ERROR} YAML linting issues found in $collection"
            ERRORS_FOUND=1
            if [ "$NO_FAIL" = "true" ]; then
                warn "Continuing despite YAML linting issues due to NO_FAIL=true"
            else
                exit 1
            fi
        else
            success "No YAML issues found in $collection"
        fi
    fi
done

if [ "$ERRORS_FOUND" -eq 0 ]; then
    if is_quiet; then
        echo "${OK}"
    else
        echo "\n${OK} All YAML files passed linting"
    fi
elif [ "$NO_FAIL" = "true" ]; then
    warn "YAML linting found issues but continuing due to NO_FAIL=true"
    exit 0
else
    exit 1
fi
