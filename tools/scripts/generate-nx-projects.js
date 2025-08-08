'use strict';

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const COLLECTIONS_DIR = path.resolve(__dirname, '../../ansible-galaxy/collections/ansible_collections/levonk');
const TEMPLATES_DIR = path.resolve(__dirname, '../templates');
const PROJECTS_DIR = path.resolve(__dirname, '../../');

// Templates
const COLLECTION_TEMPLATE = fs.readFileSync(path.join(TEMPLATES_DIR, 'collection-project.json'), 'utf8');
const ROLE_TEMPLATE = fs.readFileSync(path.join(TEMPLATES_DIR, 'role-project.json'), 'utf8');

/**
 * Replace template variables in a string
 * @param {string} template - Template string
 * @param {Object} vars - Variables to replace
 * @returns {string} - Processed string
 */
function processTemplate(template, vars) {
  let result = template;
  Object.entries(vars).forEach(([key, value]) => {
    const regex = new RegExp(`{{${key}}}`, 'g');
    result = result.replace(regex, value);
  });
  return result;
}

/**
 * Create a directory if it doesn't exist
 * @param {string} dir - Directory path
 */
function ensureDirectoryExists(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

/**
 * Get all collection directories
 * @returns {Array<string>} - Collection names
 */
function getCollections() {
  try {
    return fs.readdirSync(COLLECTIONS_DIR)
      .filter(file => fs.statSync(path.join(COLLECTIONS_DIR, file)).isDirectory());
  } catch (error) {
    console.error(`Error reading collections directory: ${error.message}`);
    return [];
  }
}

/**
 * Get all roles for a collection
 * @param {string} collection - Collection name
 * @returns {Array<string>} - Role names
 */
function getRoles(collection) {
  const rolesDir = path.join(COLLECTIONS_DIR, collection, 'roles');
  try {
    if (fs.existsSync(rolesDir)) {
      return fs.readdirSync(rolesDir)
        .filter(file => fs.statSync(path.join(rolesDir, file)).isDirectory());
    }
    return [];
  } catch (error) {
    console.error(`Error reading roles for collection ${collection}: ${error.message}`);
    return [];
  }
}

/**
 * Generate project.json for a collection
 * @param {string} collection - Collection name
 */
function generateCollectionProject(collection) {
  const projectDir = path.join(PROJECTS_DIR, 'collections', collection);
  ensureDirectoryExists(projectDir);
  
  const projectJson = processTemplate(COLLECTION_TEMPLATE, {
    collectionName: collection
  });
  
  fs.writeFileSync(path.join(projectDir, 'project.json'), projectJson);
  console.log(`Generated project.json for collection: ${collection}`);
}

/**
 * Generate project.json for a role
 * @param {string} collection - Collection name
 * @param {string} role - Role name
 */
function generateRoleProject(collection, role) {
  const projectDir = path.join(PROJECTS_DIR, 'collections', collection, 'roles', role);
  ensureDirectoryExists(projectDir);
  
  const projectJson = processTemplate(ROLE_TEMPLATE, {
    collectionName: collection,
    roleName: role
  });
  
  fs.writeFileSync(path.join(projectDir, 'project.json'), projectJson);
  console.log(`Generated project.json for role: ${collection}/${role}`);
}

/**
 * Generate workspace.json file
 * @param {Object} projects - Map of project names to project paths
 */
function generateWorkspaceJson(projects) {
  const workspaceJson = {
    version: 2,
    projects
  };
  
  fs.writeFileSync(path.join(PROJECTS_DIR, 'workspace.json'), JSON.stringify(workspaceJson, null, 2));
  console.log('Generated workspace.json');
}

/**
 * Main function
 */
function main() {
  console.log('Generating Nx project configuration...');
  
  // Create collections directory
  ensureDirectoryExists(path.join(PROJECTS_DIR, 'collections'));
  
  // Map to store project paths
  const projects = {};
  
  // Process all collections
  const collections = getCollections();
  console.log(`Found ${collections.length} collections`);
  
  collections.forEach(collection => {
    // Generate collection project
    generateCollectionProject(collection);
    projects[collection] = `collections/${collection}`;
    
    // Process roles for this collection
    const roles = getRoles(collection);
    console.log(`Found ${roles.length} roles in collection ${collection}`);
    
    roles.forEach(role => {
      generateRoleProject(collection, role);
      projects[`${collection}-${role}`] = `collections/${collection}/roles/${role}`;
    });
  });
  
  // Generate workspace.json
  generateWorkspaceJson(projects);
  
  console.log('Nx project configuration generated successfully!');
}

// Run the main function
main();
