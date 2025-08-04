#!/bin/bash
# Script to set up a new Ansible module with all required files
# Usage: ./setup-new30-module.sh <collection_name> <module_name> [module_type]

set -e  # Exit immediately if a command exits with a non-zero status

# Check if collection and module names are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <collection_name> <module_name> [module_type]"
  echo "Example: $0 my_collection my_module"
  echo "Module types: module (default), inventory, lookup, filter, test"
  exit 1
fi

COLLECTION_NAME="$1"
MODULE_NAME="$2"
MODULE_TYPE="${3:-module}"  # Default to 'module' if not specified

# Use relative paths based on script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BASE_DIR="$ROOT_DIR/ansible-galaxy"
COLLECTION_DIR="$BASE_DIR/collections/ansible_collections/levonk/$COLLECTION_NAME"

# Validate collection exists
if [ ! -d "$COLLECTION_DIR" ]; then
  echo "Error: Collection '$COLLECTION_NAME' not found in $BASE_DIR/collections/ansible_collections/levonk/"
  exit 1
fi

# Create appropriate directory based on module type
case "$MODULE_TYPE" in
  module)
    MODULE_DIR="$COLLECTION_DIR/plugins/modules"
    ;;
  inventory)
    MODULE_DIR="$COLLECTION_DIR/plugins/inventory"
    ;;
  lookup)
    MODULE_DIR="$COLLECTION_DIR/plugins/lookup"
    ;;
  filter)
    MODULE_DIR="$COLLECTION_DIR/plugins/filter"
    ;;
  test)
    MODULE_DIR="$COLLECTION_DIR/plugins/test"
    ;;
  *)
    echo "Error: Invalid module type: $MODULE_TYPE"
    echo "Valid types: module, inventory, lookup, filter, test"
    exit 1
    ;;
esac

# Create module directory if it doesn't exist
mkdir -p "$MODULE_DIR"

# Create module file with basic template
MODULE_FILE="$MODULE_DIR/$MODULE_NAME.py"
if [ -f "$MODULE_FILE" ]; then
  echo "Error: Module '$MODULE_NAME' already exists in collection '$COLLECTION_NAME'"
  exit 1
fi

# Create basic module template
cat > "$MODULE_FILE" << EOF
#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) $(date +%Y) Levon Kayan <levon@levonkayan.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: $MODULE_NAME
short_description: $MODULE_NAME module
version_added: "1.0.0"
description:
  - This is a sample module for $MODULE_NAME.
author:
  - Levon Kayan (@levonk)
options:
  name:
    description:
      - The name of the resource.
    required: true
    type: str
  state:
    description:
      - The desired state of the resource.
    choices: [ present, absent ]
    default: present
    type: str
'''

EXAMPLES = '''
- name: Test $MODULE_NAME module
  levonk.$COLLECTION_NAME.$MODULE_NAME:
    name: test
    state: present
  register: result
'''

RETURN = '''
changed:
  description: Whether the module made any changes.
  returned: always
  type: bool
  sample: true
message:
  description: A message describing the result.
  returned: always
  type: str
  sample: 'Resource created successfully'
'''

from ansible.module_utils.basic import AnsibleModule

def run_module():
    # Define available arguments/parameters
    module_args = dict(
        name=dict(type='str', required=True),
        state=dict(type='str', default='present', choices=['present', 'absent'])
    )

    # Seed the result dict
    result = dict(
        changed=False,
        message=''
    )

    # Create the module
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # Handle check mode
    if module.check_mode:
        module.exit_json(**result)

    # Your module logic here
    try:
        name = module.params['name']
        state = module.params['state']

        # Example logic - replace with actual implementation
        if state == 'present':
            result['message'] = f"Resource {name} created"
        else:
            result['message'] = f"Resource {name} removed"
            
        result['changed'] = True
        
    except Exception as e:
        module.fail_json(msg=f"An error occurred: {str(e)}", **result)

    # Return results
    module.exit_json(**result)

def main():
    run_module()

if __name__ == '__main__':
    main()
EOF

# Make the module executable
chmod +x "$MODULE_FILE"

# Create tests directory if it doesn't exist
TEST_DIR="$COLLECTION_DIR/tests/integration/targets/$MODULE_NAME"
mkdir -p "$TEST_DIR"

# Create basic test playbook
cat > "$TEST_DIR/test.yml" << EOF
---
- name: Test $MODULE_NAME module
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Test $MODULE_NAME
      levonk.$COLLECTION_NAME.$MODULE_NAME:
        name: "test_$MODULE_NAME"
        state: present
      register: result

    - name: Show result
      debug:
        var: result

    - name: Assert the result
      assert:
        that:
          - result is changed
          - result.message is defined
EOF

echo "\n✅ Successfully created new $MODULE_TYPE '$MODULE_NAME' in collection 'levonk.$COLLECTION_NAME'"
echo "\n📁 Module file: $MODULE_FILE"
echo "📝 Test file: $TEST_DIR/test.yml"
echo "\nNext steps:"
echo "1. Implement your module logic in $MODULE_FILE"
echo "2. Add proper documentation and examples"
echo "3. Test your module with: make test"
echo ""
