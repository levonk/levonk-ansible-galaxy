'use strict';

const { execSync } = require('child_process');
const path = require('path');

/**
 * Execute a shell script or command with environment variables
 * @param {Object} options - Executor options
 * @param {Object} context - Execution context
 */
function runExecutor(options, context) {
  try {
    console.log(`\x1b[36m> Executing task: ${context.targetName}\x1b[0m`);
    
    // Determine what to execute (script or command)
    let command;
    if (options.script) {
      const scriptPath = path.resolve(context.root, options.script);
      command = scriptPath;
      
      // Add arguments if provided
      if (options.args && Array.isArray(options.args)) {
        command += ' ' + options.args.join(' ');
      }
    } else if (options.command) {
      command = options.command;
    } else {
      throw new Error('Either script or command must be provided');
    }
    
    // Determine working directory
    const cwd = options.cwd 
      ? path.resolve(context.root, options.cwd)
      : context.cwd || context.root;
    
    console.log(`\x1b[90m> Working directory: ${cwd}\x1b[0m`);
    console.log(`\x1b[90m> Running: ${command}\x1b[0m`);
    
    // Prepare environment variables
    const env = { ...process.env };
    
    // Add project-specific environment variables
    if (options.env) {
      Object.entries(options.env).forEach(([key, value]) => {
        env[key] = value;
      });
    }
    
    // Execute the command
    const output = execSync(command, {
      cwd,
      env,
      stdio: 'inherit',
      shell: true
    });
    
    console.log(`\x1b[32m✓ Task ${context.targetName} completed successfully\x1b[0m`);
    
    return {
      success: true
    };
  } catch (error) {
    console.error(`\x1b[31m✗ Task ${context.targetName} failed: ${error.message}\x1b[0m`);
    return {
      success: false,
      error: error.message
    };
  }
}

module.exports = runExecutor;
