'use strict';

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const rootDir = path.resolve(__dirname, '../..');
const packageJson = require(path.join(rootDir, 'package.json'));

// Get project version from package.json or from the version script
let version = packageJson.version;
try {
  version = execSync(`${rootDir}/bin/print-version.sh 2>/dev/null || echo ${version}`, { encoding: 'utf8' }).trim();
} catch (error) {
  // Ignore errors and use package.json version
}

// Function to get all collections
function getCollections() {
  const collectionsDir = path.join(rootDir, 'ansible-galaxy/collections/ansible_collections/levonk');
  try {
    return fs.readdirSync(collectionsDir)
      .filter(file => fs.statSync(path.join(collectionsDir, file)).isDirectory());
  } catch (error) {
    return [];
  }
}

// Function to get all roles for a collection
function getRoles(collection) {
  const rolesDir = path.join(rootDir, 'ansible-galaxy/collections/ansible_collections/levonk', collection, 'roles');
  try {
    if (fs.existsSync(rolesDir)) {
      return fs.readdirSync(rolesDir)
        .filter(file => fs.statSync(path.join(rolesDir, file)).isDirectory());
    }
    return [];
  } catch (error) {
    return [];
  }
}

// Print header
console.log(`\n\x1b[1mlevonk-ansible-galaxy - Nx Build System\x1b[0m`);
console.log(`=================================================`);
console.log(`\n\x1b[1mProject Information:\x1b[0m`);
console.log(`  • Version: ${version}`);
console.log(`  • Namespace: levonk`);

const collections = getCollections();
console.log(`  • Collections: ${collections.length} found`);

// Print core targets
console.log(`\n\x1b[1mCore Targets:\x1b[0m`);
console.log(`  nx run-many --target=build --all       Build all collections`);
console.log(`  nx run-many --target=test --all        Run tests for all collections`);
console.log(`  nx run-many --target=lint --all        Run all linters`);
console.log(`  nx run-many --target=publish-beta --all Publish to beta channel`);
console.log(`  nx run-many --target=publish-prod --all Publish to production`);

// Print collection-specific targets
console.log(`\n\x1b[1mCollection-Specific Targets:\x1b[0m`);
console.log(`  nx build [collection]                  Build specific collection`);
console.log(`  nx test [collection]                   Test specific collection`);
console.log(`  nx lint [collection]                   Lint specific collection`);
console.log(`  nx publish-beta [collection]           Publish specific collection to beta`);
console.log(`  nx publish-prod [collection]           Publish specific collection to production`);
console.log(`  nx promote-build [collection]          Promote collection with build version increment`);
console.log(`  nx promote-minor [collection]          Promote collection with minor version increment`);
console.log(`  nx promote-major [collection]          Promote collection with major version increment`);

// Print installation targets
console.log(`\n\x1b[1mInstallation Targets:\x1b[0m`);
console.log(`  nx inst-src [collection]               Install from source directories`);
console.log(`  nx inst-repo [collection]              Install from git repository`);
console.log(`  nx inst-build [collection]             Install from built artifacts`);
console.log(`  nx inst-beta [collection]              Install from beta server`);
console.log(`  nx inst-prod [collection]              Install from production server`);
console.log(`  nx uninstall [collection]              Uninstall collection`);

// Print role-specific targets
console.log(`\n\x1b[1mRole-Specific Targets:\x1b[0m`);
console.log(`  nx test [collection]-[role]            Test specific role`);
console.log(`  nx lint [collection]-[role]            Lint specific role`);
console.log(`  nx molecule [collection]-[role]        Run molecule tests for role`);

// Print development targets
console.log(`\n\x1b[1mDevelopment Targets:\x1b[0m`);
console.log(`  npm run new-collection -- --name=NAME  Create a new collection`);
console.log(`  npm run new-role -- --collection=COLL --name=NAME  Create a new role`);
console.log(`  npm run new-module -- --collection=COLL --name=NAME  Create a new module`);

// Print available collections and roles
console.log(`\n\x1b[1mAvailable Collections:\x1b[0m`);
collections.forEach(collection => {
  console.log(`  • ${collection}`);
  
  const roles = getRoles(collection);
  if (roles.length > 0) {
    console.log(`    Roles:`);
    roles.forEach(role => {
      console.log(`    - ${role}`);
    });
  }
});

// Print help footer
console.log(`\n\x1b[1mFor more information:\x1b[0m`);
console.log(`  • Run 'nx graph' to visualize the project graph`);
console.log(`  • Check the README.md for detailed documentation`);
console.log(`  • Visit https://nx.dev for Nx documentation`);
