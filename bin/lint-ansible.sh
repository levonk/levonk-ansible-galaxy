#!/bin/sh

# Lint Ansible files with ansible-lint

# Source common functions
. "$(dirname "$0")/common.sh"

# Default values
COLLECTIONS_DIR="$(get_collections_dir)"
QUIET="${QUIET:-false}"
VERBOSE="${VERBOSE:-false}"
NO_FAIL="${NO_FAIL:-false}"

# Check if ansible-lint is installed
if ! command_exists ansible-lint; then
    warn "ansible-lint not found. Skipping Ansible linting."
    warn "Install with: pip install ansible-lint"
    exit 0
fi

# Skip list for ansible-lint
SKIP_LIST="no-changed-when,no-handler,command-instead-of-module"

echo "Linting Ansible files..."

ERRORS_FOUND=0
for collection in $(get_collections); do
    collection_dir="${COLLECTIONS_DIR}/${collection}"
    
    if [ ! -d "$collection_dir" ]; then
        warn "Directory not found: $collection_dir"
        continue
    fi

    if is_quiet; then
        # Quiet mode - minimal output
        if ! (cd "$collection_dir" && ansible-lint -q --skip-list="$SKIP_LIST" .) >/dev/null 2>&1; then
            echo "${ERROR} (run with VERBOSE=1 for details)"
            echo "Error: Linting issues found in $collection"
            ERRORS_FOUND=1
            [ "$NO_FAIL" = "true" ] || exit 1
        fi
    else
        # Verbose mode - show all details
        echo "=== Linting Ansible files in levonk.${collection} ==="
        if ! (cd "$collection_dir" && ansible-lint --skip-list="$SKIP_LIST" .); then
            echo "${ERROR} Linting issues found in $collection"
            ERRORS_FOUND=1
            if [ "$NO_FAIL" = "true" ]; then
                warn "Continuing despite linting issues due to NO_FAIL=true"
            else
                exit 1
            fi
        else
            success "No issues found in $collection"
        fi
    fi
done

if [ "$ERRORS_FOUND" -eq 0 ]; then
    success "All Ansible files passed linting"
elif [ "$NO_FAIL" = "true" ]; then
    warn "Ansible linting found issues but continuing due to NO_FAIL=true"
    exit 0
else
    exit 1
fi
