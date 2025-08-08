'use strict';

const fs = require('fs');
const path = require('path');

// Configuration
const ROOT_DIR = path.resolve(__dirname, '../..');
const README_PATH = path.join(ROOT_DIR, 'README.md');
const NX_DOCS_PATH = path.join(ROOT_DIR, 'NX-BUILD-SYSTEM.md');
const MIGRATION_GUIDE_PATH = path.join(ROOT_DIR, 'MIGRATION-GUIDE.md');

// Read the current README.md
let readmeContent = fs.readFileSync(README_PATH, 'utf8');

// Check if the Nx build system section already exists
if (readmeContent.includes('## Nx Build System')) {
  console.log('Nx build system section already exists in README.md');
  process.exit(0);
}

// Find the position to insert the Nx build system section
// We'll insert it after the "Development Workflow" section
const insertPosition = readmeContent.indexOf('## Development Workflow');
if (insertPosition === -1) {
  console.error('Could not find "## Development Workflow" section in README.md');
  process.exit(1);
}

// Find the next section after "Development Workflow"
const nextSectionPosition = readmeContent.indexOf('##', insertPosition + 1);
if (nextSectionPosition === -1) {
  console.error('Could not find next section after "## Development Workflow" in README.md');
  process.exit(1);
}

// Create the Nx build system section
const nxBuildSystemSection = `

## Nx Build System

This project now supports an Nx build system in addition to the Makefile system. The Nx build system provides the same functionality as the Makefile system but with additional benefits like caching, dependency management, and parallel execution.

### Installation

To set up the Nx build system:

\`\`\`bash
# Install dependencies
npm install

# Generate Nx project configuration
npm run setup
\`\`\`

### Usage

The Nx build system provides commands that map directly to the Makefile targets:

\`\`\`bash
# Build all collections
npm run build

# Build a specific collection
nx build common

# Test all collections
npm run test

# Test a specific collection
nx test common

# Test a specific role
nx test common-example

# Lint all collections
npm run lint

# Lint a specific collection
nx lint common

# Lint a specific role
nx lint common-example

# Create a new collection
npm run new-collection -- --name=example

# Create a new role
npm run new-role -- --collection=common --name=example

# Create a new module
npm run new-module -- --collection=common --name=example

# Show help
npm run help
\`\`\`

For a complete list of commands and more information, see the [Nx Build System Documentation](./NX-BUILD-SYSTEM.md) and the [Migration Guide](./MIGRATION-GUIDE.md).

`;

// Insert the Nx build system section
const updatedReadmeContent = readmeContent.slice(0, nextSectionPosition) + 
                             nxBuildSystemSection + 
                             readmeContent.slice(nextSectionPosition);

// Write the updated README.md
fs.writeFileSync(README_PATH, updatedReadmeContent);

console.log('Added Nx build system section to README.md');
