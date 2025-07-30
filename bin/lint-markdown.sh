#!/bin/sh

# Lint Markdown files with markdownlint

# Source common functions
. "$(dirname "$0")/common.sh"

# Default values
COLLECTIONS_DIR="$(get_collections_dir)"
QUIET="${QUIET:-false}"
VERBOSE="${VERBOSE:-false}"
NO_FAIL="${NO_FAIL:-false}"

# Check if markdownlint is installed
if ! command_exists markdownlint; then
    warn "markdownlint not found. Skipping Markdown linting."
    warn "Install with: npm install -g markdownlint-cli"
    exit 0
fi

echo -n "Linting Markdown files... "

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
        if ! find "$collection_dir" -name "*.md" -type f -exec markdownlint -q {} + 2>/dev/null; then
            echo "${ERROR}"
            echo "Error: Markdown linting issues found in $collection. Run with VERBOSE=1 for details."
            ERRORS_FOUND=1
            [ "$NO_FAIL" = "true" ] || exit 1
        fi
    else
        # Verbose mode - show all details
        echo "\n=== Linting Markdown files in levonk.${collection} ==="
        if ! find "$collection_dir" -name "*.md" -type f -print0 | xargs -0 -r markdownlint; then
            echo "${ERROR} Markdown linting issues found in $collection"
            ERRORS_FOUND=1
            if [ "$NO_FAIL" = "true" ]; then
                warn "Continuing despite Markdown linting issues due to NO_FAIL=true"
            else
                exit 1
            fi
        else
            success "No Markdown issues found in $collection"
        fi
    fi
done

if [ "$ERRORS_FOUND" -eq 0 ]; then
    if is_quiet; then
        echo "${OK}"
    else
        echo "\n${OK} All Markdown files passed linting"
    fi
elif [ "$NO_FAIL" = "true" ]; then
    warn "Markdown linting found issues but continuing due to NO_FAIL=true"
    exit 0
else
    exit 1
fi
