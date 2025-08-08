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
    description: 'Name of the collection to add the module to',
    type: 'string',
    demandOption: true
  })
  .option('name', {
    alias: 'n',
    description: 'Name of the module to create',
    type: 'string',
    demandOption: true
  })
  .help()
  .argv;

const collectionName = argv.collection;
const moduleName = argv.name;
const rootDir = path.resolve(__dirname, '../..');
const binDir = path.join(rootDir, 'bin');
const projectsDir = path.join(rootDir, 'collections');
const collectionsDir = path.join(rootDir, 'ansible-galaxy/collections/ansible_collections/levonk');

console.log(`\x1b[36m> Creating new module: ${moduleName} in collection ${collectionName}\x1b[0m`);

// Validate module name
if (!/^[a-z0-9_]+$/.test(moduleName)) {
  console.error('\x1b[31mError: Module name must contain only lowercase letters, numbers, and underscores\x1b[0m');
  process.exit(1);
}

try {
  // Check if collection exists
  const collectionPath = path.join(collectionsDir, collectionName);
  if (!fs.existsSync(collectionPath)) {
    console.error(`\x1b[31mError: Collection ${collectionName} does not exist\x1b[0m`);
    process.exit(1);
  }
  
  // Create module directory structure
  const modulesDir = path.join(collectionPath, 'plugins/modules');
  if (!fs.existsSync(modulesDir)) {
    fs.mkdirSync(modulesDir, { recursive: true });
  }
  
  // Create module file
  const moduleFile = path.join(modulesDir, `${moduleName}.py`);
  if (fs.existsSync(moduleFile)) {
    console.error(`\x1b[31mError: Module ${moduleName} already exists in collection ${collectionName}\x1b[0m`);
    process.exit(1);
  }
  
  // Module template
  const moduleTemplate = `#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) ${new Date().getFullYear()}, Levon Karayan
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import absolute_import, division, print_function
__metaclass__ = type

DOCUMENTATION = r'''
---
module: ${moduleName}
short_description: Module for ${moduleName}
description:
  - This module provides functionality for ${moduleName}
author:
  - "Levon Karayan"
options:
  name:
    description:
      - Name parameter
    type: str
    required: true
'''

EXAMPLES = r'''
- name: Example usage
  levonk.${collectionName}.${moduleName}:
    name: example
'''

RETURN = r'''
original_message:
    description: The original name param that was passed in
    type: str
    returned: always
    sample: 'example'
message:
    description: The output message that the module generates
    type: str
    returned: always
    sample: 'hello world'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
    )

    # seed the result dict in the object
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed
    result['original_message'] = module.params['name']
    result['message'] = f'Hello {module.params["name"]}'
    
    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    result['changed'] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # module.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
`;

  // Write module file
  fs.writeFileSync(moduleFile, moduleTemplate);
  console.log(`\x1b[32m✓ Module ${moduleName} created successfully in collection ${collectionName}\x1b[0m`);
  
  // Create module documentation directory
  const docsDir = path.join(collectionPath, 'docs/modules');
  if (!fs.existsSync(docsDir)) {
    fs.mkdirSync(docsDir, { recursive: true });
  }
  
  // Create module documentation file
  const docFile = path.join(docsDir, `${moduleName}.rst`);
  const docTemplate = `${moduleName}
${'='.repeat(moduleName.length)}

.. Automatically generated by Ansible

Synopsis
--------

* This module provides functionality for ${moduleName}

Parameters
----------

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Parameter</th>
            <th>Choices/<font color="blue">Defaults</font></th>
            <th width="100%">Comments</th>
        </tr>
        <tr>
            <td colspan="1">
                <b>name</b>
                <div style="font-size: small">
                    <span style="color: purple">string</span>
                    <br>
                    <span style="color: red">required</span>
                </div>
            </td>
            <td>
            </td>
            <td>
                <div>Name parameter</div>
            </td>
        </tr>
    </table>

Examples
--------

.. code-block:: yaml

    - name: Example usage
      levonk.${collectionName}.${moduleName}:
        name: example

Return Values
------------

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Key</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
        <tr>
            <td colspan="1">
                <b>message</b>
                <div style="font-size: small">
                    <span style="color: purple">string</span>
                </div>
            </td>
            <td>always</td>
            <td>
                <div>The output message that the module generates</div>
                <br/>
                <div style="font-size: smaller"><b>Sample:</b></div>
                <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">hello world</div>
            </td>
        </tr>
        <tr>
            <td colspan="1">
                <b>original_message</b>
                <div style="font-size: small">
                    <span style="color: purple">string</span>
                </div>
            </td>
            <td>always</td>
            <td>
                <div>The original name param that was passed in</div>
                <br/>
                <div style="font-size: smaller"><b>Sample:</b></div>
                <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">example</div>
            </td>
        </tr>
    </table>
`;

  fs.writeFileSync(docFile, docTemplate);
  console.log(`\x1b[32m✓ Module documentation created successfully\x1b[0m`);
  
  // Create module test directory
  const testsDir = path.join(collectionPath, 'tests/modules');
  if (!fs.existsSync(testsDir)) {
    fs.mkdirSync(testsDir, { recursive: true });
  }
  
  // Create module test file
  const testFile = path.join(testsDir, `test_${moduleName}.py`);
  const testTemplate = `#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) ${new Date().getFullYear()}, Levon Karayan
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import absolute_import, division, print_function
__metaclass__ = type

import pytest
from ansible.module_utils import basic
from ansible.module_utils.common.text.converters import to_bytes
import json
import sys
import os

# Add the module path to sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../plugins/modules')))
import ${moduleName}


def set_module_args(args):
    """Prepare arguments so that they will be picked up during module creation"""
    args = json.dumps({'ANSIBLE_MODULE_ARGS': args})
    basic._ANSIBLE_ARGS = to_bytes(args)


class AnsibleExitJson(Exception):
    """Exception class to be raised by module.exit_json and caught by the test case"""
    pass


class AnsibleFailJson(Exception):
    """Exception class to be raised by module.fail_json and caught by the test case"""
    pass


def exit_json(*args, **kwargs):
    """function to patch over exit_json; package return data into an exception"""
    if 'changed' not in kwargs:
        kwargs['changed'] = False
    raise AnsibleExitJson(kwargs)


def fail_json(*args, **kwargs):
    """function to patch over fail_json; package return data into an exception"""
    kwargs['failed'] = True
    raise AnsibleFailJson(kwargs)


def test_module_fail_when_required_args_missing():
    with pytest.raises(AnsibleFailJson):
        set_module_args({})
        ${moduleName}.main()


def test_module_success():
    set_module_args({
        'name': 'test'
    })
    
    with pytest.raises(AnsibleExitJson) as result:
        ${moduleName}.main()
    
    assert result.value.args[0]['changed'] is True
    assert result.value.args[0]['message'] == 'Hello test'
    assert result.value.args[0]['original_message'] == 'test'


def test_module_fail():
    set_module_args({
        'name': 'fail'
    })
    
    with pytest.raises(AnsibleFailJson) as result:
        ${moduleName}.main()
    
    assert result.value.args[0]['failed'] is True
    assert 'You requested this to fail' in result.value.args[0]['msg']
`;

  fs.writeFileSync(testFile, testTemplate);
  console.log(`\x1b[32m✓ Module tests created successfully\x1b[0m`);
  
  console.log('\x1b[36m> Module creation complete. You can now use the module in your playbooks:\x1b[0m');
  console.log(`  - name: Example usage of new module`);
  console.log(`    levonk.${collectionName}.${moduleName}:`);
  console.log(`      name: example`);
  
} catch (error) {
  console.error(`\x1b[31mError creating module: ${error.message}\x1b[0m`);
  process.exit(1);
}
