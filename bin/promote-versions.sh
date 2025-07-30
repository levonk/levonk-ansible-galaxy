#!/bin/bash
# promote-versions.sh - Version promotion script for Ansible collections
# Supports major, minor, and build version increments

set -e  # Exit immediately if a command exits with a non-zero status

# Default increment type
INCREMENT_TYPE="build"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --type=*)
      INCREMENT_TYPE="${1#*=}"
      shift
      ;;
    *)
      # Assume these are the required positional arguments
      if [ -z "$COLLECTIONS_DIR" ]; then
        COLLECTIONS_DIR="$1"
      elif [ -z "$COLLECTIONS" ]; then
        COLLECTIONS="$1"
      fi
      shift
      ;;
  esac
done

# Validate required arguments
if [ -z "$COLLECTIONS_DIR" ] || [ -z "$COLLECTIONS" ]; then
  echo "Usage: $0 [--type=major|minor|build] <collections-dir> <collections-list>"
  echo "Example: $0 --type=minor /path/to/collections 'collection1 collection2 collection3'"
  exit 1
fi

# Validate increment type
case $INCREMENT_TYPE in
  major|minor|build)
    # Valid types, continue
    ;;
  *)
    echo "Error: Invalid increment type '$INCREMENT_TYPE'. Must be one of: major, minor, build"
    exit 1
    ;;
esac

BETA_SERVER="https://galaxy-dev.ansible.com"
echo "Promoting collections (${INCREMENT_TYPE} version increment) for collections that exist on beta server..."

for collection in $COLLECTIONS; do
  echo -e "\n=== Processing levonk.$collection ==="
  
  # Check if galaxy.yml exists
  if [ ! -f "${COLLECTIONS_DIR}/$collection/galaxy.yml" ]; then
    echo "Warning: No galaxy.yml found for $collection, skipping promotion."
    continue
  fi
  
  # Get current version from galaxy.yml
  CURRENT_VERSION=$(grep -E "^version:" "${COLLECTIONS_DIR}/$collection/galaxy.yml" | awk '{print $2}' | tr -d '"' | tr -d "'")
  echo "Current version: $CURRENT_VERSION"
  
  # Parse the version components
  MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
  MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
  PATCH=$(echo $CURRENT_VERSION | cut -d. -f3 || echo "0")
  
  # Calculate new version based on increment type
  case $INCREMENT_TYPE in
    major)
      NEW_MAJOR=$((MAJOR + 1))
      NEW_VERSION="${NEW_MAJOR}.0.0"
      ;;
    minor)
      NEW_MINOR=$((MINOR + 1))
      NEW_VERSION="${MAJOR}.${NEW_MINOR}.0"
      ;;
    build)
      NEW_PATCH=$((PATCH + 1))
      NEW_VERSION="${MAJOR}.${MINOR}.${NEW_PATCH}"
      ;;
  esac
  
  # Check if collection exists on beta server
  if ansible-galaxy collection list --server "$BETA_SERVER" | grep -q "levonk.$collection"; then
    SERVER_VERSION=$(ansible-galaxy collection list --server "$BETA_SERVER" | grep "levonk.$collection" | awk '{print $2}')
    echo "Version on beta server: $SERVER_VERSION"
    
    # Only update if the version is different from the server
    if [ "$CURRENT_VERSION" != "$SERVER_VERSION" ] || [ "$INCREMENT_TYPE" != "build" ]; then
      echo "Updating version to: $NEW_VERSION (${INCREMENT_TYPE} increment)"
      
      # Update the galaxy.yml file
      sed -i "s/^version:.*/version: $NEW_VERSION/" "${COLLECTIONS_DIR}/$collection/galaxy.yml"
      echo "Updated galaxy.yml for levonk.$collection"
    else
      echo "Version matches server and build increment requested, no change needed."
    fi
  else
    echo "Collection not found on beta server, no version change needed."
  fi
done

echo -e "\nPromotion complete."
