#!/bin/bash
# Print the current version of the project
# This script can be customized to extract version from different sources

# Default version if no other source is found
DEFAULT_VERSION="0.1.0"

# Try to get version from git tag if available
if command -v git >/dev/null 2>&1; then
    VERSION=$(git describe --tags --abbrev=0 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "$VERSION"
        exit 0
    fi
fi

# Try to get version from package.json if it exists
if [ -f "package.json" ]; then
    VERSION=$(jq -r '.version' package.json 2>/dev/null)
    if [ $? -eq 0 ] && [ "$VERSION" != "null" ]; then
        echo "$VERSION"
        exit 0
    fi
fi

# Fall back to default version if no other source found
echo "$DEFAULT_VERSION"
