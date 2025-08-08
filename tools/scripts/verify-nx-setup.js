'use strict';

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const ROOT_DIR = path.resolve(__dirname, '../..');
const COLLECTIONS_DIR = path.join(ROOT_DIR, 'collections');
const ANSIBLE_COLLECTIONS_DIR = path.join(ROOT_DIR, 'ansible-galaxy/collections/ansible_collections/levonk');
const TOOLS_DIR = path.join(ROOT_DIR, 'tools');

// Color codes for console output
const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
  cyan: '\x1b[36m',
  white: '\x1b[37m'
};

/**
 * Check if a file exists
 * @param {string} filePath - Path to the file
 * @returns {boolean} - Whether the file exists
 */
function fileExists(filePath) {
  try {
    return fs.existsSync(filePath);
  } catch (error) {
    return false;
  }
}

/**
 * Check if a directory exists
 * @param {string} dirPath - Path to the directory
 * @returns {boolean} - Whether the directory exists
 */
function directoryExists(dirPath) {
  try {
    return fs.existsSync(dirPath) && fs.statSync(dirPath).isDirectory();
  } catch (error) {
    return false;
  }
}

/**
 * Print a status message
 * @param {string} message - Message to print
 * @param {boolean} success - Whether the check was successful
 */
function printStatus(message, success) {
  const icon = success ? '✓' : '✗';
  const color = success ? colors.green : colors.red;
  console.log(`${color}${icon} ${message}${colors.reset}`);
}

/**
 * Print a section header
 * @param {string} title - Section title
 */
function printSection(title) {
  console.log(`\n${colors.cyan}=== ${title} ===${colors.reset}`);
}

/**
 * Get all collection directories
 * @returns {Array<string>} - Collection names
 */
function getCollections() {
  try {
    return fs.readdirSync(ANSIBLE_COLLECTIONS_DIR)
      .filter(file => fs.statSync(path.join(ANSIBLE_COLLECTIONS_DIR, file)).isDirectory());
  } catch (error) {
    console.error(`Error reading collections directory: ${error.message}`);
    return [];
  }
}

/**
 * Check Nx configuration files
 */
function checkNxConfig() {
  printSection('Checking Nx Configuration Files');
  
  // Check nx.json
  const nxJsonExists = fileExists(path.join(ROOT_DIR, 'nx.json'));
  printStatus('nx.json exists', nxJsonExists);
  
  // Check workspace.json
  const workspaceJsonExists = fileExists(path.join(ROOT_DIR, 'workspace.json'));
  printStatus('workspace.json exists', workspaceJsonExists);
  
  // Check package.json
  const packageJsonExists = fileExists(path.join(ROOT_DIR, 'package.json'));
  printStatus('package.json exists', packageJsonExists);
  
  // Check project.json
  const projectJsonExists = fileExists(path.join(ROOT_DIR, 'project.json'));
  printStatus('project.json exists', projectJsonExists);
  
  return nxJsonExists && workspaceJsonExists && packageJsonExists && projectJsonExists;
}

/**
 * Check Nx executors
 */
function checkNxExecutors() {
  printSection('Checking Nx Executors');
  
  // Check executor directory
  const executorDirExists = directoryExists(path.join(TOOLS_DIR, 'executors'));
  printStatus('executors directory exists', executorDirExists);
  
  // Check shell executor
  const shellExecutorExists = directoryExists(path.join(TOOLS_DIR, 'executors/shell'));
  printStatus('shell executor exists', shellExecutorExists);
  
  // Check shell executor files
  const executorJsonExists = fileExists(path.join(TOOLS_DIR, 'executors/shell/executor.json'));
  printStatus('executor.json exists', executorJsonExists);
  
  const schemaJsonExists = fileExists(path.join(TOOLS_DIR, 'executors/shell/schema.json'));
  printStatus('schema.json exists', schemaJsonExists);
  
  const implJsExists = fileExists(path.join(TOOLS_DIR, 'executors/shell/impl.js'));
  printStatus('impl.js exists', implJsExists);
  
  return executorDirExists && shellExecutorExists && executorJsonExists && schemaJsonExists && implJsExists;
}

/**
 * Check Nx scripts
 */
function checkNxScripts() {
  printSection('Checking Nx Scripts');
  
  // Check scripts directory
  const scriptsDirExists = directoryExists(path.join(TOOLS_DIR, 'scripts'));
  printStatus('scripts directory exists', scriptsDirExists);
  
  // Check script files
  const generateProjectsExists = fileExists(path.join(TOOLS_DIR, 'scripts/generate-nx-projects.js'));
  printStatus('generate-nx-projects.js exists', generateProjectsExists);
  
  const generateWrappersExists = fileExists(path.join(TOOLS_DIR, 'scripts/generate-script-wrappers.js'));
  printStatus('generate-script-wrappers.js exists', generateWrappersExists);
  
  const helpExists = fileExists(path.join(TOOLS_DIR, 'scripts/help.js'));
  printStatus('help.js exists', helpExists);
  
  const newCollectionExists = fileExists(path.join(TOOLS_DIR, 'scripts/new-collection.js'));
  printStatus('new-collection.js exists', newCollectionExists);
  
  const newRoleExists = fileExists(path.join(TOOLS_DIR, 'scripts/new-role.js'));
  printStatus('new-role.js exists', newRoleExists);
  
  const newModuleExists = fileExists(path.join(TOOLS_DIR, 'scripts/new-module.js'));
  printStatus('new-module.js exists', newModuleExists);
  
  return scriptsDirExists && generateProjectsExists && generateWrappersExists && 
         helpExists && newCollectionExists && newRoleExists && newModuleExists;
}

/**
 * Check Nx templates
 */
function checkNxTemplates() {
  printSection('Checking Nx Templates');
  
  // Check templates directory
  const templatesDirExists = directoryExists(path.join(TOOLS_DIR, 'templates'));
  printStatus('templates directory exists', templatesDirExists);
  
  // Check template files
  const collectionTemplateExists = fileExists(path.join(TOOLS_DIR, 'templates/collection-project.json'));
  printStatus('collection-project.json exists', collectionTemplateExists);
  
  const roleTemplateExists = fileExists(path.join(TOOLS_DIR, 'templates/role-project.json'));
  printStatus('role-project.json exists', roleTemplateExists);
  
  return templatesDirExists && collectionTemplateExists && roleTemplateExists;
}

/**
 * Check documentation
 */
function checkDocumentation() {
  printSection('Checking Documentation');
  
  // Check documentation files
  const nxBuildSystemExists = fileExists(path.join(ROOT_DIR, 'NX-BUILD-SYSTEM.md'));
  printStatus('NX-BUILD-SYSTEM.md exists', nxBuildSystemExists);
  
  const migrationGuideExists = fileExists(path.join(ROOT_DIR, 'MIGRATION-GUIDE.md'));
  printStatus('MIGRATION-GUIDE.md exists', migrationGuideExists);
  
  return nxBuildSystemExists && migrationGuideExists;
}

/**
 * Check collection projects
 */
function checkCollectionProjects() {
  printSection('Checking Collection Projects');
  
  // Check collections directory
  const collectionsDirExists = directoryExists(COLLECTIONS_DIR);
  printStatus('collections directory exists', collectionsDirExists);
  
  // Get collections
  const collections = getCollections();
  console.log(`Found ${collections.length} collections`);
  
  // Check if at least one collection has a project.json
  let hasProjectJson = false;
  
  collections.forEach(collection => {
    const projectJsonPath = path.join(COLLECTIONS_DIR, collection, 'project.json');
    const exists = fileExists(projectJsonPath);
    if (exists) {
      hasProjectJson = true;
      printStatus(`${collection}/project.json exists`, exists);
    }
  });
  
  if (!hasProjectJson && collections.length > 0) {
    printStatus('No collection has a project.json file', false);
  }
  
  return collectionsDirExists && hasProjectJson;
}

/**
 * Check if npm packages are installed
 */
function checkNpmPackages() {
  printSection('Checking npm Packages');
  
  try {
    // Check if node_modules directory exists
    const nodeModulesExists = directoryExists(path.join(ROOT_DIR, 'node_modules'));
    printStatus('node_modules directory exists', nodeModulesExists);
    
    // Check if nx is installed
    const nxExists = directoryExists(path.join(ROOT_DIR, 'node_modules/nx'));
    printStatus('nx package is installed', nxExists);
    
    // Check if yargs is installed
    const yargsExists = directoryExists(path.join(ROOT_DIR, 'node_modules/yargs'));
    printStatus('yargs package is installed', yargsExists);
    
    return nodeModulesExists && nxExists && yargsExists;
  } catch (error) {
    printStatus('Error checking npm packages', false);
    return false;
  }
}

/**
 * Main function
 */
function main() {
  console.log(`${colors.cyan}Nx Build System Verification${colors.reset}`);
  console.log(`${colors.cyan}=========================${colors.reset}`);
  
  // Run all checks
  const nxConfigOk = checkNxConfig();
  const nxExecutorsOk = checkNxExecutors();
  const nxScriptsOk = checkNxScripts();
  const nxTemplatesOk = checkNxTemplates();
  const documentationOk = checkDocumentation();
  const collectionProjectsOk = checkCollectionProjects();
  const npmPackagesOk = checkNpmPackages();
  
  // Print summary
  printSection('Summary');
  printStatus('Nx Configuration', nxConfigOk);
  printStatus('Nx Executors', nxExecutorsOk);
  printStatus('Nx Scripts', nxScriptsOk);
  printStatus('Nx Templates', nxTemplatesOk);
  printStatus('Documentation', documentationOk);
  printStatus('Collection Projects', collectionProjectsOk);
  printStatus('npm Packages', npmPackagesOk);
  
  // Overall status
  const allOk = nxConfigOk && nxExecutorsOk && nxScriptsOk && nxTemplatesOk && 
                documentationOk && collectionProjectsOk && npmPackagesOk;
  
  console.log(`\n${allOk ? colors.green : colors.red}Overall Status: ${allOk ? 'PASS' : 'FAIL'}${colors.reset}`);
  
  if (!allOk) {
    console.log(`\n${colors.yellow}To fix issues, run:${colors.reset}`);
    console.log(`  npm install`);
    console.log(`  npm run setup`);
  } else {
    console.log(`\n${colors.green}The Nx build system is properly set up and ready to use!${colors.reset}`);
    console.log(`\n${colors.cyan}Try running:${colors.reset}`);
    console.log(`  npm run help`);
  }
}

// Run the main function
main();
