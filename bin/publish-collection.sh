#!/bin/bash
# publish-collection.sh - Common script for publishing collections to Ansible Galaxy
# This script should not be called directly - use the wrapper scripts instead

set -e  # Exit immediately if a command exits with a non-zero status

# Check if required parameters are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "ERROR: This script should not be called directly. Use the wrapper scripts instead."
  echo "Usage: $0 <server-url> <collections-list> <token> [dist-dir]"
  exit 1
fi

# Parameters
SERVER_URL="$1"
COLLECTIONS="$2"
TOKEN_INPUT="$3"
DEFAULT_DIST_DIR="/mnt/d/p/gh/lrepo52/mrepo/proj/homenet/deployment-operations/3rdparty/gh/levonk/levonk-ansible-galaxy/dist"
DIST_DIR="${4:-$DEFAULT_DIST_DIR}"

# Read token from file if the input is a file
if [ -f "$TOKEN_INPUT" ]; then
  TOKEN=$(cat "$TOKEN_INPUT" | tr -d '[:space:]')
  TOKEN_SOURCE="file: $TOKEN_INPUT"
else
  TOKEN="$TOKEN_INPUT"
  TOKEN_SOURCE="environment variable"
fi

echo "=== Publishing to Ansible Galaxy Server ==="
echo "Server URL:  $SERVER_URL"
echo "Dist Dir:    $DIST_DIR"
echo "Token Source: $TOKEN_SOURCE"
echo "Token Prefix: $(echo $TOKEN | cut -c1-3)..."
echo ""

# Check if token is provided
if [ -z "$TOKEN" ]; then
  echo "ERROR: Token is not provided"
  exit 1
fi

# Check if dist directory exists
if [ ! -d "$DIST_DIR" ]; then
  echo "ERROR: Distribution directory does not exist: $DIST_DIR"
  exit 1
fi

# Publish each collection
for collection in $COLLECTIONS; do
  echo "Publishing $collection..."
  collection_file="${DIST_DIR}/levonk-${collection}-*.tar.gz"
  
  # Check if collection file exists
  if [ ! -f $collection_file ]; then
    echo "ERROR: Collection file not found: $collection_file"
    exit 1
  fi
  
  # Publish the collection
  if ! ansible-galaxy collection publish "$collection_file" --server "$SERVER_URL" --token "$TOKEN"; then
    echo "ERROR: Failed to publish $collection"
    exit 1
  fi
  
  # Verify the collection is available
  collection_name="levonk.$collection"
  echo "Verifying $collection_name is available..."
  if ! ansible-galaxy collection list "$collection_name" | grep -q "$collection_name"; then
    echo "ERROR: Failed to verify $collection_name is available"
    exit 1
  fi
  
  echo "Successfully published and verified $collection_name"
  echo ""
done

echo "All collections published successfully to $SERVER_URL"
