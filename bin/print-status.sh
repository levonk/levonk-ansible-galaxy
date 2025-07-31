#!/bin/bash
# Print the current status of the project

echo "=== Project Status ==="

# Git status
if command -v git >/dev/null 2>&1; then
    echo "\n=== Git Status ==="
    git status
    echo "\n=== Git Branches ==="
    git branch -v
    echo "\n=== Git Remote ==="
    git remote -v
fi

# Collection status
echo "\n=== Collections Status ==="
find collections/ansible_collections -name galaxy.yml -type f -exec echo "\n=== Collection: {}" \; \
    -exec grep -E '^namespace:|^name:|^version:' {} \;

# Build status
echo "\n=== Build Status ==="
if [ -d "dist" ]; then
    echo "Dist directory exists with $(ls -1 dist/ 2>/dev/null | wc -l) files"
else
    echo "Dist directory does not exist"
fi

# Environment info
echo "\n=== Environment ==="
ansible --version 2>/dev/null | head -n 1
python --version 2>/dev/null || python3 --version 2>/dev/null
