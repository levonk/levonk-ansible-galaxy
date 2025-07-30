#!/bin/sh

# Validate galaxy.yml files

# Source common functions
. "$(dirname "$0")/common.sh"

# Default values
COLLECTIONS_DIR="$(get_collections_dir)"
QUIET="${QUIET:-false}"
VERBOSE="${VERBOSE:-false}"
NO_FAIL="${NO_FAIL:-false}"

# Required fields in galaxy.yml
REQUIRED_FIELDS="namespace name version readme authors description license"

# Check if yamllint is installed for YAML syntax validation
if ! command_exists yamllint; then
    warn "yamllint not found. YAML syntax validation will be skipped."
    warn "Install with: pip install yamllint"
fi

echo -n "Validating galaxy.yml files... "

ERRORS_FOUND=0
for collection in $(get_collections); do
    collection_dir="${COLLECTIONS_DIR}/${collection}"
    galaxy_yml="${collection_dir}/galaxy.yml"
    
    if [ ! -f "$galaxy_yml" ]; then
        if ! is_quiet; then
            echo "\n=== Validating galaxy.yml for levonk.${collection} ==="
            echo "${ERROR} galaxy.yml not found in $collection"
        fi
        ERRORS_FOUND=1
        [ "$NO_FAIL" = "true" ] || exit 1
        continue
    fi

    if ! is_quiet; then
        echo "\n=== Validating galaxy.yml for levonk.${collection} ==="
    fi

    # Check YAML syntax first if yamllint is available
    if command_exists yamllint; then
        # Create a temporary directory for our custom config
        TMP_CONFIG="$(mktemp -d)/.yamllint.yml"
        cat > "$TMP_CONFIG" << 'EOF'
---
# Custom yamllint configuration that avoids the max-spaces-outside issue
# and focuses on critical YAML validation

extends: default

rules:
  # Disable problematic rules
  braces: disable
  brackets: disable
  colons: disable
  commas: disable
  comments: disable
  comments-indentation: disable
  document-end: disable
  document-start: disable
  empty-lines: disable
  empty-values: disable
  hyphens: disable
  indentation: disable
  key-duplicates: enable
  key-ordering: disable
  line-length: disable
  new-line-at-end-of-file: disable
  new-lines: disable
  trailing-spaces: disable
  truthy: disable
  # Only enable critical rules
  document-start: {present: true}
  trailing-spaces: {}
  truthy: {}
  empty-lines: {max: 3, max-start: 0, max-end: 1}
  indentation: {spaces: 2, indent-sequences: true}
  line-length: {max: 120, allow-non-breakable-words: true, allow-non-breakable-inline-mappings: true}
  key-duplicates: {}
EOF

        if ! yamllint -c "$TMP_CONFIG" -f parsable "$galaxy_yml" > /dev/null 2>&1; then
            if is_quiet; then
                echo "${ERROR}"
                echo "Error: YAML syntax issues in galaxy.yml for $collection. Run with VERBOSE=1 for details."
            else
                echo "${ERROR} YAML syntax issues in galaxy.yml"
                yamllint -c "$TMP_CONFIG" "$galaxy_yml" || true
            fi
            ERRORS_FOUND=1
            [ "$NO_FAIL" = "true" ] || { rm -rf "$(dirname "$TMP_CONFIG")"; exit 1; }
            continue
        fi
        # Clean up the temporary config
        rm -rf "$(dirname "$TMP_CONFIG")"
    fi

    # Check for required fields
    for field in $REQUIRED_FIELDS; do
        if ! grep -q "^${field}:" "$galaxy_yml"; then
            if is_quiet; then
                echo "${ERROR}"
                echo "Error: Missing required field '$field' in galaxy.yml for $collection"
            else
                echo "${ERROR} Missing required field: $field"
            fi
            ERRORS_FOUND=1
            [ "$NO_FAIL" = "true" ] || exit 1
        fi
    done

    # Check namespace is 'levonk'
    if ! grep -q "^namespace:[[:space:]]*levonk" "$galaxy_yml"; then
        if is_quiet; then
            echo "${ERROR}"
            echo "Error: Namespace must be 'levonk' in galaxy.yml for $collection"
        else
            echo "${ERROR} Namespace must be 'levonk'"
        fi
        ERRORS_FOUND=1
        [ "$NO_FAIL" = "true" ] || exit 1
    fi

    if [ "$ERRORS_FOUND" -eq 0 ]; then
        if ! is_quiet; then
            success "galaxy.yml is valid"
        fi
    fi
done

if [ "$ERRORS_FOUND" -eq 0 ]; then
    if is_quiet; then
        echo "${OK}"
    else
        echo "\n${OK} All galaxy.yml files are valid"
    fi
elif [ "$NO_FAIL" = "true" ]; then
    warn "galaxy.yml validation found issues but continuing due to NO_FAIL=true"
    exit 0
else
    exit 1
fi
