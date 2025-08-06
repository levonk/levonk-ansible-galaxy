#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) {{ year }} {{ full_name }} <{{ email }}>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: {{ cookiecutter.module_name }}
short_description: {{ cookiecutter.module_short_description }}
version_added: "1.0.0"
description: {{ cookiecutter.module_description }}
options:
    name:
        description: Name of the resource.
        required: true
        type: str
    state:
        description: State of the resource.
        choices: [ absent, present ]
        default: present
        type: str
author:
    - {{ full_name }} (@{{ github_username }})
'''

EXAMPLES = r'''
# Create a new resource
- name: Create a new resource
  {{ collection_name }}.{{ module_name }}:
    name: test-resource
    state: present

# Remove a resource
- name: Remove a resource
  {{ collection_name }}.{{ module_name }}:
    name: test-resource
    state: absent
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'test-resource'
message:
    description: The output message that the module generates.
    type: str
    returned: always
    sample: 'Resource test-resource created successfully.'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
        state=dict(type='str', default='present', choices=['absent', 'present']),
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # change is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message='',
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = module.params['name']
    result['message'] = f"Resource {module.params['name']} "
    
    if module.params['state'] == 'present':
        result['message'] += 'created successfully.'
        result['changed'] = True
    else:
        result['message'] += 'removed successfully.'
        result['changed'] = True

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
