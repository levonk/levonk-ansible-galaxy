#!/bin/bash
set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Cleaning Up Makefile System ===${NC}"

# 1. Remove backup files
echo -e "${GREEN}Removing backup files...${NC}"
rm -f Makefile.backup
rm -rf bin.backup

# 2. Remove Makefile-related files
echo -e "${GREEN}Removing Makefile-related files...${NC}"
rm -f fix_makefile.sh
rm -f restore_makefile_targets.sh
rm -f targets.txt

# 3. Update README.md to remove Makefile references
echo -e "${GREEN}Updating README.md...${NC}"
sed -i.bak '/## Makefile/,/## /d' README.md
sed -i.bak 's/^make build/nx build/g' README.md
sed -i.bak 's/^make test/nx test/g' README.md
sed -i.bak 's/^make lint/nx lint/g' README.md
rm -f README.md.bak

# 4. Update package.json to remove Makefile-related scripts
echo -e "${GREEN}Updating package.json...${NC}"
node -e "
const fs = require('fs');
const packageJsonPath = './package.json';
const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));

// Remove makefile script if it exists
if (packageJson.scripts && packageJson.scripts.makefile) {
  delete packageJson.scripts.makefile;
  fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2) + '\n');
}
"

# 5. Update CI/CD workflows
echo -e "${GREEN}Updating CI/CD workflows...${NC}"
if [ -d ".github/workflows" ]; then
  find .github/workflows -name "*.yml" -type f -exec sed -i.bak 's/make build/nx build/g' {} \;
  find .github/workflows -name "*.yml" -type f -exec sed -i.bak 's/make test/nx test/g' {} \;
  find .github/workflows -name "*.yml" -type f -exec sed -i.bak 's/make lint/nx lint/g' {} \;
  find .github/workflows -name "*.bak" -type f -delete
fi

echo -e "\n${GREEN}=== Makefile Cleanup Complete ===${NC}"
echo -e "\n${GREEN}Next steps:${NC}"
echo "1. Review the changes made to ensure everything looks correct"
echo "2. Test the Nx build system with: npm run build"
echo "3. Commit the changes to version control"
echo "4. Update any documentation or CI/CD pipelines that reference the old Makefile commands"

echo -e "\n${GREEN}You can now use Nx commands directly:${NC}"
echo "- Build: nx build"
echo "- Test: nx test"
echo "- Lint: nx lint"
echo "- For more commands, run: npx nx --help"
