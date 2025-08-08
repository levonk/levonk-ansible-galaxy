'use strict';

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const ROOT_DIR = path.resolve(__dirname, '../..');
const BIN_DIR = path.join(ROOT_DIR, 'ansible-galaxy/bin');
const WRAPPER_DIR = path.join(ROOT_DIR, 'tools/wrappers');

// Ensure wrapper directory exists
if (!fs.existsSync(WRAPPER_DIR)) {
  fs.mkdirSync(WRAPPER_DIR, { recursive: true });
}

// Get all script files in bin directory
function getScripts() {
  try {
    return fs.readdirSync(BIN_DIR)
      .filter(file => {
        const filePath = path.join(BIN_DIR, file);
        return fs.statSync(filePath).isFile() && 
               (file.endsWith('.sh') || fs.accessSync(filePath, fs.constants.X_OK));
      });
  } catch (error) {
    console.error(`Error reading bin directory: ${error.message}`);
    return [];
  }
}

// Generate a wrapper script for a bin script
function generateWrapper(scriptName) {
  const wrapperPath = path.join(WRAPPER_DIR, scriptName);
  const scriptPath = path.join(BIN_DIR, scriptName);
  
  // Skip if wrapper already exists and is newer than the script
  if (fs.existsSync(wrapperPath)) {
    const wrapperStat = fs.statSync(wrapperPath);
    const scriptStat = fs.statSync(scriptPath);
    if (wrapperStat.mtime > scriptStat.mtime) {
      console.log(`Skipping ${scriptName} (wrapper is up to date)`);
      return;
    }
  }
  
  // Create wrapper content
  const wrapperContent = `#!/bin/bash
# This is an auto-generated wrapper for the Nx build system
# Original script: ${scriptPath}

# Set up environment variables
export PROJECT_NAME=\${PROJECT_NAME:-levonk-ansible-galaxy}
export ROOT_DIR=\${ROOT_DIR:-${ROOT_DIR}}
export BIN_DIR=\${BIN_DIR:-${BIN_DIR}}
export DIST_DIR=\${DIST_DIR:-\${ROOT_DIR}/dist}
export BUILD_DIR=\${BUILD_DIR:-\${ROOT_DIR}/build}
export DOCS_DIR=\${DOCS_DIR:-\${ROOT_DIR}/docs}
export TESTS_DIR=\${TESTS_DIR:-\${ROOT_DIR}/tests}
export COLLECTIONS_DIR=\${COLLECTIONS_DIR:-\${ROOT_DIR}/ansible-galaxy/collections}
export NAMESPACE=\${NAMESPACE:-levonk}

# Execute the original script with all arguments
exec "${scriptPath}" "$@"
`;

  // Write wrapper file
  fs.writeFileSync(wrapperPath, wrapperContent);
  fs.chmodSync(wrapperPath, 0o755); // Make executable
  
  console.log(`Generated wrapper for ${scriptName}`);
}

// Main function
function main() {
  console.log('Generating script wrappers...');
  
  const scripts = getScripts();
  console.log(`Found ${scripts.length} scripts in ${BIN_DIR}`);
  
  scripts.forEach(script => {
    generateWrapper(script);
  });
  
  console.log('Script wrappers generated successfully!');
}

// Run the main function
main();
