#!/bin/bash
set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Removing Makefile System ===${NC}"

# 1. Backup existing files
echo -e "${GREEN}Creating backups...${NC}"
cp -f Makefile Makefile.backup
cp -r bin bin.backup

# 2. Remove Makefile and related files
echo -e "${GREEN}Removing Makefile and related files...${NC}"
rm -f Makefile
rm -f Makefile.nx
rm -f fix_makefile.sh
rm -f restore_makefile_targets.sh

# 3. Update README.md
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
const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));
if (packageJson.scripts && packageJson.scripts.makefile) {
  delete packageJson.scripts.makefile;
  fs.writeFileSync('package.json', JSON.stringify(packageJson, null, 2) + '\n');
}
"

# 5. Remove any remaining Makefile references in collection project.json files
echo -e "${GREEN}Cleaning up collection project files...${NC}"
find collections -name "project.json" -type f -exec sed -i.bak 's/"make build"/"nx build"/g' {} \;
find collections -name "project.json.bak" -type f -delete

# 6. Update CI/CD workflows
echo -e "${GREEN}Updating CI/CD workflows...${NC}"
find .github/workflows -name "*.yml" -type f -exec sed -i.bak 's/make build/nx build/g' {} \;
find .github/workflows -name "*.yml" -type f -exec sed -i.bak 's/make test/nx test/g' {} \;
find .github/workflows -name "*.yml" -type f -exec sed -i.bak 's/make lint/nx lint/g' {} \;
find .github/workflows -name "*.bak" -type f -delete

echo -e "\n${GREEN}=== Makefile System Removal Complete ===${NC}"
echo -e "${YELLOW}Backup files created:${NC}"
echo "- Makefile.backup"
echo "- bin.backup/"

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
