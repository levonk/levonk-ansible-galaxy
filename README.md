<!--
Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
See LICENSE file in the project root for full license information.
-->

# levonk-ansible-galaxy

This repository contains a collection of Ansible roles for managing and provisioning development and operational environments.

## Repository Structure

```
.
├── ansible-galaxy/                 # Main project directory
│   ├── bin/                       # Executable scripts for the project
│   │   ├── promote-versions.sh    # Script to increment collection versions
│   │   └── publish-beta.sh        # Script to publish to beta server
│   ├── collections/               # Ansible collections
│   │   └── ansible_collections/
│   │       └── levonk/           # Our collection namespace
│   │           ├── collection1/   # Individual collection
│   │           │   ├── roles/    # Roles within the collection
│   │           │   └── galaxy.yml
│   │           └── ...
│   ├── dist/                      # Built collection artifacts (*.tar.gz)
│   ├── .markers/                  # Marker files for build tracking
│   └── Makefile                   # Main Makefile for project operations
├── docs/                          # Documentation files
└── tests/                         # Test playbooks and test data
```

### Key Directories

- **ansible-galaxy/bin/**: Contains executable scripts for various operations like version promotion and publishing.
- **ansible-galaxy/collections/ansible_collections/levonk/**: Houses all collections under the `levonk` namespace.
  - Each subdirectory represents a collection (e.g., `vibeops/`, `server_llmchat/`).
  - Each collection contains its `roles/` directory and `galaxy.yml`.
- **ansible-galaxy/dist/**: Stores built collection artifacts (`.tar.gz` files) ready for publishing.
- **ansible-galaxy/.markers/**: Tracks build state with marker files for incremental builds.
- **tests/**: Contains test playbooks and related files for testing collections.

### Important Files

- **Makefile**: The main interface for all project operations (building, testing, publishing).
- **galaxy.yml**: Defines collection metadata and requirements.
- **ansible.cfg**: Local Ansible configuration (if present).

## Development Workflow

1. **Collection Development**: Work within `ansible-galaxy/collections/ansible_collections/levonk/{collection_name}`
2. **Building**: Use `make build` to create distribution artifacts in `dist/`
3. **Testing**: Run `make test` to execute tests
4. **Versioning**: Use `make promote` to increment versions before publishing
5. **Publishing**: Use `make publish-beta` or `make prod` to publish to respective servers

## Makefile Targets

The project uses a Makefile to automate various tasks. Here are the available targets:

### Build and Test

- `build`: Build all collections and create distribution artifacts
- `clean`: Clean the distribution directory
- `test`: Run tests for all collections
- `lint`: Run all linting checks
- `lint-ansible`: Lint Ansible roles and playbooks
- `lint-markdown`: Lint Markdown files
- `lint-yaml`: Lint YAML files
- `lint-galaxy`: Lint galaxy.yml files
- `molecule`: Run molecule tests for roles

### Version Management and Publishing

- `promote`: Increment minor version numbers for collections that already exist on the beta server
- `publish-beta`: Publish collections to the beta server (depends on promote)
- `beta`: Alias for publish-beta
- `prod`: Publish collections to the production server (requires being on env/prod branch)

### Installation

- `inst-src`: Install collections from source directories
- `inst-repo`: Install collections from git repository
- `inst-build`: Install collections from built artifacts
- `inst-beta`: Install collections from beta server
- `inst-prod`: Install collections from production server

### Development

- `new-collection`: Create a new collection
- `new-role`: Create a new role within a collection
- `debug`: Run debugging tools

### Target Dependencies

```mermaid
graph TD
    %% Main build pipeline
    clean --> build
    build --> lint
    lint --> test
    test --> promote
    promote -- "rebuilds collections" --> build
    promote --> publish-beta
    publish-beta --> prod
    
    %% Installation dependencies
    build --> inst-build
    build --> inst-src
    publish-beta --> inst-beta
    prod --> inst-prod
    
    %% Development workflow - depends on tests passing
    test --> new-collection
    test --> new-role
    test --> debug
    new-collection --> build
    new-role --> build
    
    subgraph "Installation Options"
        inst-src
        inst-repo
        inst-build
        inst-beta
        inst-prod
    end
    
    subgraph "Linting"
        lint --> lint-ansible
        lint --> lint-markdown
        lint --> lint-yaml
        lint --> lint-galaxy
    end
```


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
