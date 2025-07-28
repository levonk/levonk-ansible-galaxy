#!/bin/bash
# Script to explicitly publish collections to beta server

# Check if token is set
if [ -z "$ANSIBLE_GALAXY_TOKEN" ]; then
  echo "ERROR: ANSIBLE_GALAXY_TOKEN is not set in the environment"
  echo "Please set it with: export ANSIBLE_GALAXY_TOKEN='your_token'"
  exit 1
fi

# Display token information
echo "Token prefix: $(echo $ANSIBLE_GALAXY_TOKEN | cut -c1-3)..."

# Define the beta server URL
GALAXY_SERVER="https://galaxy-dev.ansible.com"
echo "Using server URL: $GALAXY_SERVER"

# Find all collection artifacts
DIST_DIR="/mnt/d/p/gh/lrepo52/mrepo/proj/homenet/deployment-operations/3rdparty/gh/levonk/levonk-ansible-galaxy/dist"
COLLECTIONS=$(find "$DIST_DIR" -name "*.tar.gz")

# Publish each collection
for collection in $COLLECTIONS; do
  echo "Publishing $(basename $collection) to $GALAXY_SERVER..."
  ansible-galaxy collection publish "$collection" --api-key="$ANSIBLE_GALAXY_TOKEN" --server="$GALAXY_SERVER"
  if [ $? -eq 0 ]; then
    echo "Successfully published $(basename $collection)"
  else
    echo "Failed to publish $(basename $collection)"
  fi
done

echo "Done publishing collections to beta server"
