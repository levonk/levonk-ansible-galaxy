#!/bin/bash
# publish-beta.sh - Publish collections to beta server and verify they are available

set -e  # Exit immediately if a command exits with a non-zero status

# Check if required variables are set
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <dist-dir> <collections-list> <beta-token>"
  echo "Example: $0 /path/to/dist 'collection1 collection2 collection3' \$BETA_ANSIBLE_GALAXY_TOKEN"
  exit 1
fi

DIST_DIR="$1"
COLLECTIONS="$2"
BETA_TOKEN="$3"
BETA_SERVER="https://galaxy-dev.ansible.com"

echo "Publishing collections to beta server..."
echo "Using beta server URL: $BETA_SERVER"

# Check if token is provided
if [ -z "$BETA_TOKEN" ]; then
  echo "ERROR: Beta token is not provided"
  exit 1
fi

echo "Beta token prefix: $(echo $BETA_TOKEN | cut -c1-3)..."

# Publish collections
FAILED_PUBLICATIONS=""
for collection in $(find "$DIST_DIR" -name "*.tar.gz"); do
  COLLECTION_NAME=$(basename $collection | sed -E 's/levonk-([^-]+)-.*/\1/')
  echo -e "\n=== Publishing levonk.$COLLECTION_NAME to $BETA_SERVER ==="
  
  if ! ansible-galaxy collection publish "$collection" --api-key="$BETA_TOKEN" --server="$BETA_SERVER"; then
    echo "ERROR: Failed to publish levonk.$COLLECTION_NAME to beta server."
    FAILED_PUBLICATIONS="$FAILED_PUBLICATIONS levonk.$COLLECTION_NAME"
  fi
done

# Check for failed publications
if [ -n "$FAILED_PUBLICATIONS" ]; then
  echo -e "\n\nERROR: The following collections could not be published to beta server:$FAILED_PUBLICATIONS"
  echo "Please check the error messages above for details."
  exit 1
fi

# Verify all collections are available on the beta server
echo -e "\n=== Verifying collections on beta server ==="
MISSING_COLLECTIONS=""
for collection in $COLLECTIONS; do
  if ! ansible-galaxy collection list --server "$BETA_SERVER" | grep -q "levonk.$collection"; then
    echo "ERROR: Collection levonk.$collection not found on beta server after publication!"
    MISSING_COLLECTIONS="$MISSING_COLLECTIONS levonk.$collection"
  fi
done

# Check for missing collections
if [ -n "$MISSING_COLLECTIONS" ]; then
  echo -e "\n\nERROR: The following collections are missing from the beta server:$MISSING_COLLECTIONS"
  echo "Publication failed. Please check the error messages above."
  exit 1
fi

echo -e "\n=== All collections successfully published to beta server ==="
