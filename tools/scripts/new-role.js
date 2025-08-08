'use strict';

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const yargs = require('yargs/yargs');
const { hideBin } = require('yargs/helpers');

// Parse command line arguments
const argv = yargs(hideBin(process.argv))
  .option('collection', {
    alias: 'c',
    description: 'Name of the collection to add the role to',
    type: 'string',
    demandOption: true
  })
  .option('name', {
    alias: 'n',
    description: 'Name of the role to create',
    type: 'string',
    demandOption: true
  })
  .help()
  .argv;

const collectionName = argv.collection;
const roleName = argv.name;
const rootDir = path.resolve(__dirname, '../..');
const binDir = path.join(rootDir, 'bin');
const projectsDir = path.join(rootDir, 'collections');
const templatesDir = path.join(rootDir, 'tools/templates');

console.log(`\x1b[36m> Creating new role: ${roleName} in collection ${collectionName}\x1b[0m`);

// Validate role name
if (!/^[a-z0-9_]+$/.test(roleName)) {
  console.error('\x1b[31mError: Role name must contain only lowercase letters, numbers, and underscores\x1b[0m');
  process.exit(1);
}

try {
  // Execute the existing new-role script
  execSync(`${binDir}/new-role.sh ${collectionName} ${roleName}`, {
    cwd: rootDir,
    stdio: 'inherit'
  });
  
  console.log(`\x1b[32m✓ Role ${roleName} created successfully in collection ${collectionName}\x1b[0m`);
  
  // Generate Nx project configuration for the new role
  console.log('\x1b[36m> Generating Nx project configuration...\x1b[0m');
  
  // Create project directory
  const projectDir = path.join(projectsDir, collectionName, 'roles', roleName);
  if (!fs.existsSync(projectDir)) {
    fs.mkdirSync(projectDir, { recursive: true });
  }
  
  // Read role template
  const templatePath = path.join(templatesDir, 'role-project.json');
  let template = fs.readFileSync(templatePath, 'utf8');
  
  // Replace template variables
  template = template.replace(/{{collectionName}}/g, collectionName);
  template = template.replace(/{{roleName}}/g, roleName);
  
  // Write project.json
  fs.writeFileSync(path.join(projectDir, 'project.json'), template);
  
  // Update workspace.json
  const workspacePath = path.join(rootDir, 'workspace.json');
  let workspace = { version: 2, projects: {} };
  
  if (fs.existsSync(workspacePath)) {
    workspace = JSON.parse(fs.readFileSync(workspacePath, 'utf8'));
  }
  
  workspace.projects[`${collectionName}-${roleName}`] = `collections/${collectionName}/roles/${roleName}`;
  fs.writeFileSync(workspacePath, JSON.stringify(workspace, null, 2));
  
  console.log(`\x1b[32m✓ Nx project configuration for role ${roleName} created successfully\x1b[0m`);
  console.log('\x1b[36m> You can now use nx commands with this role:\x1b[0m');
  console.log(`  nx test ${collectionName}-${roleName}`);
  console.log(`  nx lint ${collectionName}-${roleName}`);
  console.log(`  nx molecule ${collectionName}-${roleName}`);
  
} catch (error) {
  console.error(`\x1b[31mError creating role: ${error.message}\x1b[0m`);
  process.exit(1);
}
