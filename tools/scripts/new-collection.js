'use strict';

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const yargs = require('yargs/yargs');
const { hideBin } = require('yargs/helpers');

// Parse command line arguments
const argv = yargs(hideBin(process.argv))
  .option('name', {
    alias: 'n',
    description: 'Name of the collection to create',
    type: 'string',
    demandOption: true
  })
  .help()
  .argv;

const collectionName = argv.name;
const rootDir = path.resolve(__dirname, '../..');
const binDir = path.join(rootDir, 'bin');
const projectsDir = path.join(rootDir, 'collections');
const templatesDir = path.join(rootDir, 'tools/templates');

console.log(`\x1b[36m> Creating new collection: ${collectionName}\x1b[0m`);

// Validate collection name
if (!/^[a-z0-9_]+$/.test(collectionName)) {
  console.error('\x1b[31mError: Collection name must contain only lowercase letters, numbers, and underscores\x1b[0m');
  process.exit(1);
}

try {
  // Execute the existing new-collection script
  execSync(`${binDir}/new-collection.sh ${collectionName}`, {
    cwd: rootDir,
    stdio: 'inherit'
  });
  
  console.log(`\x1b[32m✓ Collection ${collectionName} created successfully\x1b[0m`);
  
  // Generate Nx project configuration for the new collection
  console.log('\x1b[36m> Generating Nx project configuration...\x1b[0m');
  
  // Create project directory
  const projectDir = path.join(projectsDir, collectionName);
  if (!fs.existsSync(projectDir)) {
    fs.mkdirSync(projectDir, { recursive: true });
  }
  
  // Read collection template
  const templatePath = path.join(templatesDir, 'collection-project.json');
  let template = fs.readFileSync(templatePath, 'utf8');
  
  // Replace template variables
  template = template.replace(/{{collectionName}}/g, collectionName);
  
  // Write project.json
  fs.writeFileSync(path.join(projectDir, 'project.json'), template);
  
  // Update workspace.json
  const workspacePath = path.join(rootDir, 'workspace.json');
  let workspace = { version: 2, projects: {} };
  
  if (fs.existsSync(workspacePath)) {
    workspace = JSON.parse(fs.readFileSync(workspacePath, 'utf8'));
  }
  
  workspace.projects[collectionName] = `collections/${collectionName}`;
  fs.writeFileSync(workspacePath, JSON.stringify(workspace, null, 2));
  
  console.log(`\x1b[32m✓ Nx project configuration for ${collectionName} created successfully\x1b[0m`);
  console.log('\x1b[36m> You can now use nx commands with this collection:\x1b[0m');
  console.log(`  nx build ${collectionName}`);
  console.log(`  nx test ${collectionName}`);
  console.log(`  nx lint ${collectionName}`);
  
} catch (error) {
  console.error(`\x1b[31mError creating collection: ${error.message}\x1b[0m`);
  process.exit(1);
}
