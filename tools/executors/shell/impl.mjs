import { execSync } from 'node:child_process';
import path from 'node:path';

/**
 * Execute a shell script or command with environment variables (ESM)
 * @param {Object} options - Executor options
 * @param {Object} context - Execution context
 * @returns {Promise<{success: boolean, error?: string}>}
 */
export default async function runExecutor(options, context) {
  try {
    console.log(`\x1b[36m> Executing task: ${context?.targetName ?? 'unknown'}\x1b[0m`);

    // Determine what to execute (script or command)
    let command;
    if (options.script) {
      const scriptPath = path.resolve(context.root, options.script);
      command = scriptPath;
      if (options.args && Array.isArray(options.args) && options.args.length > 0) {
        command += ' ' + options.args.join(' ');
      }
    } else if (options.command) {
      command = options.command;
    } else {
      throw new Error('Either "script" or "command" must be provided');
    }

    // Working directory
    const cwd = options.cwd
      ? path.resolve(context.root, options.cwd)
      : context.cwd || context.root;

    console.log(`\x1b[90m> Working directory: ${cwd}\x1b[0m`);
    console.log(`\x1b[90m> Running: ${command}\x1b[0m`);

    // Environment
    const env = { ...process.env };
    if (options.env && typeof options.env === 'object') {
      for (const [k, v] of Object.entries(options.env)) {
        env[k] = String(v);
      }
    }

    // Execute
    execSync(command, {
      cwd,
      env,
      stdio: 'inherit',
      shell: true,
    });

    console.log(`\x1b[32m✓ Task ${context?.targetName ?? 'unknown'} completed successfully\x1b[0m`);
    return { success: true };
  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error);
    console.error(`\x1b[31m✗ Task ${context?.targetName ?? 'unknown'} failed: ${msg}\x1b[0m`);
    return { success: false, error: msg };
  }
}
