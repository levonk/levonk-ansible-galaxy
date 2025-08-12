'use strict';

// CJS shim to load the ESM executor for Nx v16 which requires() executors
module.exports = async function runExecutor(options, context) {
  const mod = await import('./impl.mjs');
  const fn = mod && (mod.default || mod.runExecutor || mod.executor || mod.run);
  if (typeof fn !== 'function') {
    throw new Error('ESM executor did not export a function (default)');
  }
  return fn(options, context);
};
