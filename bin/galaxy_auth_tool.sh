#!/bin/bash
# Comprehensive Ansible Galaxy Authentication Tool
# Combines debugging, testing, and fixing functionality for Galaxy authentication issues

set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
GALAXY_SERVER="https://galaxy-dev.ansible.com"
PERFORM_FIX=false
TEST_PUBLISH=false
VERBOSE=false
COLLECTION_PATH="dist"

# Display help
function show_help {
  echo -e "${BLUE}=== Ansible Galaxy Authentication Tool ===${NC}"
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  -s, --server URL     Specify Galaxy server URL (default: $GALAXY_SERVER)"
  echo "  -t, --token TOKEN    Specify Galaxy token (alternative to env var)"
  echo "  -f, --fix            Attempt to fix common issues"
  echo "  -p, --publish        Test publishing a collection"
  echo "  -v, --verbose        Show verbose output"
  echo "  -h, --help           Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0                   Basic authentication check"
  echo "  $0 --fix             Check and fix common issues"
  echo "  $0 --publish         Test publishing a collection"
  echo "  $0 --server https://galaxy.ansible.com  Check auth with production server"
  echo ""
  echo "Note: Set ANSIBLE_GALAXY_TOKEN environment variable or use --token option"
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -s|--server) GALAXY_SERVER="$2"; shift ;;
    -t|--token) export ANSIBLE_GALAXY_TOKEN="$2"; shift ;;
    -f|--fix) PERFORM_FIX=true ;;
    -p|--publish) TEST_PUBLISH=true ;;
    -v|--verbose) VERBOSE=true ;;
    -h|--help) show_help; exit 0 ;;
    *) echo "Unknown parameter: $1"; show_help; exit 1 ;;
  esac
  shift
done

# Header
echo -e "${BLUE}=== Ansible Galaxy Authentication Tool ===${NC}"
echo -e "${BLUE}=== Server: ${GALAXY_SERVER} ===${NC}"

# Check if token is set
if [ -z "$ANSIBLE_GALAXY_TOKEN" ]; then
  echo -e "${RED}ERROR: ANSIBLE_GALAXY_TOKEN is not set in the environment${NC}"
  echo "Please set it with: export ANSIBLE_GALAXY_TOKEN='your_token'"
  echo "Or use the --token option: $0 --token your_token"
  exit 1
fi

# Display token information (safely)
TOKEN_LENGTH=$(echo -n "$ANSIBLE_GALAXY_TOKEN" | wc -c)
echo -e "${BLUE}Token Information:${NC}"
echo "Token length: $TOKEN_LENGTH characters"
echo "Token prefix: $(echo "$ANSIBLE_GALAXY_TOKEN" | cut -c1-3)..."

# Check if token has quotes or other issues
if [[ "$ANSIBLE_GALAXY_TOKEN" == *"'"* || "$ANSIBLE_GALAXY_TOKEN" == *"\""* ]]; then
  echo -e "${YELLOW}WARNING: Your token contains quotes which may cause issues${NC}"
  echo "Try setting it without quotes: export ANSIBLE_GALAXY_TOKEN=your_token"
  
  if [ "$PERFORM_FIX" = true ]; then
    echo -e "${GREEN}Fixing: Removing quotes from token...${NC}"
    ANSIBLE_GALAXY_TOKEN=$(echo $ANSIBLE_GALAXY_TOKEN | tr -d "'\"")
    echo "Token fixed. New prefix: $(echo "$ANSIBLE_GALAXY_TOKEN" | cut -c1-3)..."
  fi
fi

# Test basic connectivity
echo -e "\n${BLUE}Testing basic connectivity...${NC}"
BASIC_CONN=$(curl -s -I "$GALAXY_SERVER" | head -n 1)
echo "$BASIC_CONN"

if [[ "$BASIC_CONN" != *"200 OK"* && "$BASIC_CONN" != *"302"* ]]; then
  echo -e "${RED}ERROR: Cannot connect to Galaxy server${NC}"
  echo "Check your internet connection and the server URL"
  exit 1
fi

# Test authentication with different API versions
echo -e "\n${BLUE}Testing authentication with API v3...${NC}"
AUTH_V3=$(curl -s -I -H "Authorization: Token $ANSIBLE_GALAXY_TOKEN" "$GALAXY_SERVER/api/v3/" | head -n 1)
echo "$AUTH_V3"

echo -e "\n${BLUE}Testing authentication with API v2...${NC}"
AUTH_V2=$(curl -s -I -H "Authorization: Token $ANSIBLE_GALAXY_TOKEN" "$GALAXY_SERVER/api/v2/" | head -n 1)
echo "$AUTH_V2"

echo -e "\n${BLUE}Testing authentication with base API...${NC}"
AUTH_BASE=$(curl -s -I -H "Authorization: Token $ANSIBLE_GALAXY_TOKEN" "$GALAXY_SERVER/api/" | head -n 1)
echo "$AUTH_BASE"

# Determine which API version works best
if [[ "$AUTH_V3" == *"200 OK"* ]]; then
  BEST_API="v3"
  AUTH_OK=true
elif [[ "$AUTH_V2" == *"200 OK"* ]]; then
  BEST_API="v2"
  AUTH_OK=true
elif [[ "$AUTH_BASE" == *"200 OK"* ]]; then
  BEST_API="base"
  AUTH_OK=true
else
  AUTH_OK=false
  BEST_API="none"
fi

# Try with trailing slash removed if all failed
if [ "$AUTH_OK" = false ]; then
  FIXED_URL=$(echo "$GALAXY_SERVER" | sed 's/\/$//')
  echo -e "\n${BLUE}Trying with trailing slash removed: $FIXED_URL${NC}"
  AUTH_FIXED=$(curl -s -I -H "Authorization: Token $ANSIBLE_GALAXY_TOKEN" "$FIXED_URL/api/v3/" | head -n 1)
  echo "$AUTH_FIXED"
  
  if [[ "$AUTH_FIXED" == *"200 OK"* ]]; then
    echo -e "${GREEN}Success with fixed URL!${NC}"
    GALAXY_SERVER=$FIXED_URL
    BEST_API="v3"
    AUTH_OK=true
  fi
fi

# Check if ansible-galaxy is properly configured
echo -e "\n${BLUE}Checking ansible-galaxy configuration...${NC}"
if [ "$VERBOSE" = true ]; then
  ansible-galaxy collection list --server="$GALAXY_SERVER"
else
  ansible-galaxy collection list --server="$GALAXY_SERVER" | head -n 5
  echo "..."
fi

# Summary of authentication status
echo -e "\n${BLUE}=== Authentication Summary ===${NC}"
if [ "$AUTH_OK" = true ]; then
  echo -e "${GREEN}Authentication successful!${NC}"
  echo "Best API version: $BEST_API"
  echo "Server URL: $GALAXY_SERVER"
else
  echo -e "${RED}Authentication failed!${NC}"
  echo "Please check your token and server URL"
fi

# Fix Makefile if requested
if [ "$PERFORM_FIX" = true ]; then
  echo -e "\n${BLUE}=== Fixing Makefile ===${NC}"
  
  if [ -f "ansible-galaxy/Makefile" ]; then
    echo "Updating the Makefile to use API $BEST_API explicitly..."
    
    if [ "$BEST_API" = "v3" ]; then
      sed -i 's|--server="${GALAXY_SERVER}"|--server="${GALAXY_SERVER}/api/v3/"|g' ansible-galaxy/Makefile 2>/dev/null || echo "Could not update Makefile"
      echo -e "${GREEN}Updated Makefile to use API v3${NC}"
    elif [ "$BEST_API" = "v2" ]; then
      sed -i 's|--server="${GALAXY_SERVER}"|--server="${GALAXY_SERVER}/api/v2/"|g' ansible-galaxy/Makefile 2>/dev/null || echo "Could not update Makefile"
      echo -e "${GREEN}Updated Makefile to use API v2${NC}"
    else
      echo -e "${YELLOW}No API version works well - not updating Makefile${NC}"
    fi
  else
    echo -e "${YELLOW}Makefile not found at ansible-galaxy/Makefile${NC}"
  fi
  
  # Check for runtime.yml files
  echo -e "\n${BLUE}Checking for required runtime.yml files...${NC}"
  MISSING_RUNTIME=false
  
  for collection_dir in ansible-galaxy/collections/ansible_collections/levonk/*; do
    if [ -d "$collection_dir" ]; then
      collection_name=$(basename "$collection_dir")
      if [ ! -f "$collection_dir/meta/runtime.yml" ]; then
        echo -e "${YELLOW}Missing runtime.yml in $collection_name${NC}"
        MISSING_RUNTIME=true
      else
        if ! grep -q "requires_ansible:" "$collection_dir/meta/runtime.yml" || grep -q "# requires_ansible:" "$collection_dir/meta/runtime.yml"; then
          echo -e "${YELLOW}requires_ansible is commented out or missing in $collection_name${NC}"
          MISSING_RUNTIME=true
        fi
      fi
    fi
  done
  
  if [ "$MISSING_RUNTIME" = true ]; then
    echo -e "${YELLOW}Some collections are missing proper runtime.yml files${NC}"
    echo "Consider running bin/setup_new_collection.sh to create new collections with proper structure"
  else
    echo -e "${GREEN}All collections have proper runtime.yml files${NC}"
  fi
fi

# Test publishing if requested
if [ "$TEST_PUBLISH" = true ]; then
  echo -e "\n${BLUE}=== Testing Collection Publishing ===${NC}"
  
  # Find a collection to publish
  COLLECTION=$(find "$COLLECTION_PATH" -name "*.tar.gz" | head -n 1)
  
  if [ -n "$COLLECTION" ]; then
    echo "Found collection: $(basename $COLLECTION)"
    echo -e "${YELLOW}Attempting to publish $(basename $COLLECTION)...${NC}"
    
    if [ "$VERBOSE" = true ]; then
      ansible-galaxy collection publish "$COLLECTION" --api-key="$ANSIBLE_GALAXY_TOKEN" --server="$GALAXY_SERVER"
    else
      ansible-galaxy collection publish "$COLLECTION" --api-key="$ANSIBLE_GALAXY_TOKEN" --server="$GALAXY_SERVER" || echo -e "${RED}Publishing failed${NC}"
    fi
    
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Success! Collection published successfully.${NC}"
    else
      echo -e "${RED}Failed to publish collection${NC}"
    fi
  else
    echo -e "${YELLOW}No collections found in $COLLECTION_PATH directory.${NC}"
    echo "Run 'make build' first to create collection artifacts"
  fi
fi

# Provide guidance
echo -e "\n${BLUE}=== Troubleshooting Tips ===${NC}"
echo "1. Make sure your token is for the correct server (dev vs production)"
echo "2. Try setting the token without quotes: export ANSIBLE_GALAXY_TOKEN=your_token"
echo "3. Check if the token has expired - generate a new one if needed"
echo "4. Verify the server URL is correct: $GALAXY_SERVER"
echo "5. Make sure each collection has meta/runtime.yml with requires_ansible field"
echo "6. Check if your network allows connections to the Galaxy server"

echo -e "\n${BLUE}=== Next Steps ===${NC}"
if [ "$AUTH_OK" = true ]; then
  echo "1. Run 'make build' to build your collections"
  echo "2. Run 'make beta' to publish to the beta server"
  echo "3. Or run 'bin/publish_beta.sh' to explicitly publish all collections"
else
  echo "1. Fix the authentication issues mentioned above"
  echo "2. Run this script again with --fix to attempt automatic fixes"
fi

echo -e "\n${GREEN}Done!${NC}"
