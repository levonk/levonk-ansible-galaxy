<!--
Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
-->

# levonk-ansible-galaxy

This repository contains a collection of Ansible roles for managing and provisioning development and operational environments.


## Use your collections

### Publish publicly

You'll access it at https://galaxy.ansible.com/

But we want to do local testing first, right?

### CLI method

This tells Ansible to only search the specified path, overriding the ansible.cfg setting. This is useful for one-off tests.

```bash
ansible-playbook your_playbook.yml -c {repo-root}/ansible-galaxy/collections/
```


### Modeify Your cfg

This is what the repo structure looks like:

```bash
{repo-root}/
  └── ansible-galaxy/
	  └── collections/ (point `~/.ansible/ansible.cfg [defaults]\n collection_paths={repo-root}/collections:...`)
	      └── ansible_collections/
		  └── levonk/
		      └── base_system/
			  ├── roles/
			  │   └── base_system/
			  │       └── tasks/
			  │           └── main.yml
			  ├── galaxy.yml (Required but can be minimal)
			  └── README.md (Recommended)
```

Key points:

1. ansible-galaxy: This is your top-level project directory. It can be named anything.
2. collections: This must be named collections. Ansible looks for collections here by default (when you configure the collections_paths).
3. ansible_collections: This must also be named ansible_collections.
4. levonk: Your namespace.
5. base_system: Your collection name.
6. roles: This contains the actual roles.
7. base_system (inside roles): The actual role directory containing tasks, handlers, vars, etc.
8. galaxy.yml: A basic galaxy.yml file is required.


When you run `ansible-playbook your_playbook.yml` from within `{repo-root}/`, Ansible will:
1. Find ansible.cfg in the same directory.
2. Read the `collections_paths` setting from that file.
3. Search `./{repo-root}/ansible-galaxy/collections/` first. Since `your_playbook.yml` and `ansible-galaxy` are in the same directory, `./` refers to that directory.
4. Find `levonk.base_system` in `ansible-galaxy/collections/ansible_collections/levonk/base_system`.
5. Run the role.

`~/.ansible/ansible.cfg` should read
```ini
[defaults]
collection_paths={repo-root}/ansible-galaxy/collections:{the-other-paths}

```
-     `./ansible-galaxy/collections/`: This is the crucial part. It tells Ansible to look relative to your playbook's location inside the ansible-galaxy/collections/ directory. Make sure you replace ansible-galaxy with the name of your actual directory. Crucially, if your ansible.cfg is in the same directory as your playbook, ./ refers to that playbook's directory. If your ansible.cfg is in ~/.ansible, then ./ is relative to your home directory, not your playbook's location.
-     `~/.ansible/collections`: This is included to keep the standard user-level collection path in the search order.
-     `/usr/share/ansible/collections`: This keeps the system-wide collection path in the search order.
