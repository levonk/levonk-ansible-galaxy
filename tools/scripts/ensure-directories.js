'use strict';

const fs = require('fs');
const path = require('path');

// Configuration
const ROOT_DIR = path.resolve(__dirname, '../..');
const COLLECTIONS_DIR = path.join(ROOT_DIR, 'collections');
const ANSIBLE_COLLECTIONS_DIR = path.join(ROOT_DIR, 'ansible-galaxy/collections/ansible_collections/levonk');

/**
 * Create a directory if it doesn't exist
 * @param {string} dir - Directory path
 */
function ensureDirectoryExists(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
    console.log(`Created directory: ${dir}`);
  }
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
 * Get all roles for a collection
 * @param {string} collection - Collection name
 * @returns {Array<string>} - Role names
 */
function getRoles(collection) {
  const rolesDir = path.join(ANSIBLE_COLLECTIONS_DIR, collection, 'roles');
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
 * Main function
 */
function main() {
  console.log('Ensuring directories for Nx project structure...');
  
  // Create collections directory
  ensureDirectoryExists(COLLECTIONS_DIR);
  
  // Process all collections
  const collections = getCollections();
  console.log(`Found ${collections.length} collections`);
  
  collections.forEach(collection => {
    // Create collection directory
    const collectionDir = path.join(COLLECTIONS_DIR, collection);
    ensureDirectoryExists(collectionDir);
    
    // Process roles for this collection
    const roles = getRoles(collection);
    console.log(`Found ${roles.length} roles in collection ${collection}`);
    
    // Create roles directory
    const rolesDir = path.join(collectionDir, 'roles');
    ensureDirectoryExists(rolesDir);
    
    roles.forEach(role => {
      // Create role directory
      const roleDir = path.join(rolesDir, role);
      ensureDirectoryExists(roleDir);
    });
  });
  
  console.log('Directory structure ensured successfully!');
}

// Run the main function
main();
