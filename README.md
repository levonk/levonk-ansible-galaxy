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
│   │   └── publish-*.sh        # Script to publish on galaxy servers
│   │   └── install-*.sh        # Script to install
│   ├── collections/               # Ansible collections
│   │   └── blueprint_collections/ # A template collection
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

## Containerized Development Environment

This project uses Docker containers to provide a consistent development and testing environment. The container setup includes:

### Container Architecture

1. **Base Environment**
   - Minimal Debian-based image
   - Common utilities and dependencies
   - Non-root user setup
   - Volume mounts for source code and artifacts

2. **Build Environment** (extends Base)
   - Python and Ansible development tools
   - Build dependencies
   - Linting and testing tools
   - Used for building and testing collections

3. **Runtime Environment** (extends Base)
   - Minimal Python and Ansible runtime
   - Used for testing installed collections
   - Verifies package installation and basic functionality

### Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- Git

### Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd levonk-ansible-galaxy
   ```

2. **Build the development containers**
   ```bash
   docker compose build
   ```

3. **Start the development environment**
   ```bash
   docker compose up -d
   ```

4. **Access the build container**
   ```bash
   docker compose exec builder bash
   ```

### Development Workflow

1. **Start the development environment**
   ```bash
   docker compose up -d
   ```

2. **Enter the build container**
   ```bash
   docker compose exec builder bash
   ```

3. **Build and test collections**
   ```bash
   # Inside the container
   make build lint test
   ```

4. **Test installation in a clean environment**
   ```bash
   # From host machine
   docker compose exec runtime ansible --version
   ```

### Container Services

| Service | Purpose | Access |
|---------|---------|--------|
| `builder` | Development and build environment | `docker compose exec builder bash` |
| `runtime` | Clean environment for testing installations | `docker compose exec runtime bash` |

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
  - Run with `V=1` for verbose output (e.g., `make V=1 build`)
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

## Workflow Overview

### Development Workflow
For regular development and testing:
- `ee-clean`, `clean` → `build` → `lint` → `test-build` → (`test-src` | `test-repo`)

All test targets automatically clean the execution environment (`ee-clean`) before running to ensure consistent test results.

### Publishing Pipeline

#### Beta Release (run `make beta`)
1. **Phase 1: Verify Current Version**
   - Clean environment and verify all prerequisites
   - Build and test with current version numbers
   - Run coverage checks

2. **Phase 2: Promote Version**
   - Update version numbers according to semantic versioning

3. **Phase 3: Verify New Version**
   - Rebuild and retest with new version numbers
   - Ensures the new version builds correctly before publishing

4. **Phase 4: Publish to Beta**
   - `publish-beta`: Upload to beta server
   - `test-beta`: Verify installation from beta server
   - `git-tag-beta`: Create version tag in `tags/env/beta/{YYYYMM}/levonk-{version}`
   - `inst-beta`: (Optional) Install beta version locally

#### Production Release (run `make prod`)
> **Prerequisite**: A successful beta release must be completed first

1. **Phase 1: Verify Beta Complete**
   - Checks that beta release was successful
   - Ensures we only promote to production what's been tested in beta

2. **Phase 2: Backup Production**
   - `backup-prod`: Create backup of current production state
   - Required before any production changes

3. **Phase 3: Publish to Production**
   - `publish-prod`: Promote beta release to production
   - Uses the same artifacts that were verified in beta

4. **Phase 4: Verify Production**
   - `test-prod`: Verify installation from production
   - `rollback-prod`: (Auto-triggered on failure) Restore from backup

5. **Phase 5: Finalize Production**
   - `git-tag-prod`: Create production version tag in `tags/env/prod/{YYYYMM}/levonk-{version}`
   - `inst-prod`: (Optional) Install production version locally

### New Component Workflow
For adding new collections/roles:
1. `test-build` → `git-check-clean-dev`: Ensure clean state
2. `new-collection`/`new-role`: Scaffold new component
3. `build` → `lint` → `test-build`: Verify changes
4. `git-commit`: Create initial commit

```mermaid
graph TD
    %% Environment reset (run manually when needed)
    subgraph "Environment Reset (run manually when needed)"
        ee-clean --> env-check
        env-check --> ee-check
        ee-check --> clean
    end

    %% Normal development workflow
    subgraph "Development Workflow"
        build --> lint
        lint --> test-build
        test-build --> test-src
    end
    
    %% Repository-based testing (for testing against published collections)
    test-repo["test-repo: Test against published collections"]
    
    %% ============================================
    %% Beta Release Pipeline
    %% ============================================
    
    %% Phase 1: Verify with current version
    beta-phase1-verify["Phase 1: Verify Current Version"]
    beta-phase1-verify --> ee-clean
    beta-phase1-verify --> env-check
    env-check --> ee-check
    ee-check --> git-check-clean-publish
    git-check-clean-publish --> clean
    clean --> build
    build --> lint
    lint --> test-build
    test-build --> coverage-check
    
    %% Phase 2: Promote and verify new version
    beta-phase2-promote["Phase 2: Promote Version"]
    coverage-check --> beta-phase2-promote
    beta-phase2-promote --> promote
    
    beta-phase3-verify["Phase 3: Verify New Version"]
    promote --> beta-phase3-verify
    beta-phase3-verify --> ee-clean
    ee-clean --> env-check
    env-check --> ee-check
    ee-check --> git-check-clean-publish
    git-check-clean-publish --> clean
    clean --> build
    build --> lint
    lint --> test-build
    test-build --> coverage-check
    
    %% Phase 4: Publish to Beta
    beta-phase4-publish["Phase 4: Publish to Beta"]
    coverage-check --> beta-phase4-publish
    beta-phase4-publish --> publish-beta
    publish-beta --> test-beta
    test-beta --> git-tag-beta
    git-tag-beta --> inst-beta
    
    %% Beta convenience target - runs all beta release phases
    beta: beta-phase1-verify  # Start with Phase 1 verification
    beta-phase1-verify --> beta-phase2-promote  # Then promote version
    beta-phase2-promote --> beta-phase3-verify  # Then verify new version
    beta-phase3-verify --> beta-phase4-publish  # Then publish to beta
    
    %% ============================================
    %% Production Release Pipeline
    %% ============================================
    
    %% Production Workflow
    
    %% Phase 1: Verify Beta is Complete (prerequisite)
    prod-phase1-beta["Phase 1: Verify Beta Complete"]
    %% Production requires beta to be complete first
    beta-phase4-publish --> prod-phase1-beta
    
    %% Phase 2: Backup Production
    prod-phase2-backup["Phase 2: Backup Production"]
    prod-phase1-beta --> prod-phase2-backup
    prod-phase2-backup --> backup-prod
    
    %% Phase 3: Publish to Production
    prod-phase3-publish["Phase 3: Publish to Production"]
    backup-prod --> prod-phase3-publish
    prod-phase3-publish --> publish-prod
    
    %% Phase 4: Verify Production
    prod-phase4-verify["Phase 4: Verify Production"]
    publish-prod --> test-prod
    
    %% Phase 5: Finalize Production
    prod-phase5-finalize["Phase 5: Finalize Production"]
    test-prod --> git-tag-prod
    git-tag-prod --> inst-prod
    
    %% Rollback on failure
    test-prod -.->|on failure| rollback-prod
    git-tag-prod -.->|on failure| rollback-prod
    
    %% Production convenience target - runs all production release phases
    prod: prod-phase1-beta  # Start with Phase 1 (beta verification)
    prod-phase1-beta --> prod-phase2-backup  # Then Phase 2 (backup)
    prod-phase2-backup --> prod-phase3-publish  # Then Phase 3 (publish)
    prod-phase3-publish --> prod-phase4-verify  # Then Phase 4 (verify)
    prod-phase4-verify --> prod-phase5-finalize  # Then Phase 5 (finalize)
    
    %% New component workflow
    test-build --> git-check-clean-dev
    git-check-clean-dev --> new-collection
    git-check-clean-dev --> new-role
    new-collection --> build
    new-role --> build
    build --> lint
    lint --> test-build
    test-build --> git-commit
    
    subgraph "Local Installation"
        inst-src
        inst-repo
        inst-build
        inst-beta
        inst-prod
    end
    
    subgraph "Publishing"
        publish-beta
        publish-prod
    end
    
    subgraph "Docker Testing"
        ee-build
        ee-clean
        ee-check
        ee-lint
        ee-shell
        test-src
        test-repo
        test-build
        test-beta
        test-prod
    end
    
    subgraph "Linting"
        lint --> lint-ansible
        lint --> lint-markdown
        lint --> lint-yaml
        lint --> lint-galaxy
    end

  %% Environment Checks
    subgraph "Environment Checks"
        env-check --> check-linters
        env-check --> check-tests
        env-check --> check-tools
        
        %% Linters group
        check-linters --> check-ansible-lint
        check-linters --> check-yamllint
        check-linters --> check-markdownlint
        check-linters --> check-flake8
        
        %% Tests group
        check-tests --> check-pytest
        check-tests --> check-tox
        check-tests --> check-molecule
        
        %% Tools group
        check-tools --> check-git
        check-tools --> check-python
        check-tools --> check-ansible
        check-tools --> check-pyenv
        check-tools --> check-uv
        check-tools --> check-docker
        check-tools --> check-make
    end
```

## Makefile Reference

This project uses a Makefile to automate common development and deployment tasks. Below is a reference of all available targets organized by workflow.

### Development Workflow

| Target | Description |
|--------|-------------|
| `all` | Build and test all collections (default) |
| `build` | Build all collections |
| `clean` | Remove build artifacts |
| `lint` | Run all linters (includes all lint-* targets) |
| `lint-ansible` | Lint Ansible content |
| `lint-markdown` | Lint Markdown files |
| `lint-yaml` | Lint YAML files |
| `lint-galaxy` | Lint galaxy.yml files |
| `test` | Run tests on all collections |
| `test-build` | Build and run tests in a container |
| `test-src` | Test installation from source |
| `test-repo` | Test installation from repository |
| `coverage-check` | Verify test coverage meets requirements |
| `ee-clean` | Clean execution environment images |

### Publishing Workflow

| Target | Description |
|--------|-------------|
| `promote` | Update version numbers |
| `publish-beta` | Upload to beta server |
| `test-beta` | Verify installation from beta server |
| `git-tag-beta` | Create beta version tag |
| `beta` | Complete beta release workflow |
| `backup-prod` | Backup current production state |
| `publish-prod` | Promote to production server |
| `test-prod` | Verify installation from production |
| `git-tag-prod` | Create production version tag |
| `prod` | Complete production release workflow |
| `rollback-prod` | Restore from production backup |

### Local Installation

| Target | Description |
|--------|-------------|
| `inst-src` | Install from source |
| `inst-repo` | Install from git repository |
| `inst-build` | Install from local build |
| `inst-beta` | Install from beta server |
| `inst-prod` | Install from production server |

### Component Management

| Target | Description |
|--------|-------------|
| `new-collection` | Create a new collection |
| `new-role` | Create a new role in a collection |
| `promote-build` | Promote with build version increment |
| `promote-minor` | Promote with build version increment |
| `promote-major` | Promote with major version increment |
| `promote` | Alias for promote-build |
| `publish-beta` | Publish to beta server |
| `prod` | Publish to production server |

### Installation Methods

| Target | Description |
|--------|-------------|
| `inst-beta` | Install from beta server |
| `inst-build` | Install from built artifacts |
| `inst-prod` | Install from production server |
| `inst-repo` | Install from git repository |
| `inst-src` | Install from source directories |

### Execution Environment

| Target | Description |
|--------|-------------|
| `ee-build` | Build the execution environment image |
| `ee-clean` | Clean up execution environment images |
| `ee-lint` | Run linters in the execution environment |
| `ee-shell` | Start a shell in the execution environment |
| `ee-test` | Run tests in the execution environment |
| `env-check` | Check whatever environment clean and with tooling |
| `ee-check` | Check docker environment clean and with tooling |

### Environment Checks

| Target | Description | Dependencies |
|--------|-------------|--------------|
| `check-git` | Verify git installation | - |
| `check-python` | Verify Python installation | - |
| `check-ansible` | Verify Ansible installation | `check-python` |
| `check-pyenv` | Verify pyenv installation | - |
| `check-uv` | Verify uv installation | `check-python` |
| `check-docker` | Verify Docker/Podman installation | - |
| `check-make` | Verify make installation | - |
| `check-ansible-lint` | Verify ansible-lint | `check-python` |
| `check-yamllint` | Verify yamllint | `check-python` |
| `check-markdownlint` | Verify markdownlint | `check-node` |
| `check-flake8` | Verify flake8 | `check-python` |
| `check-pytest` | Verify pytest | `check-python` |
| `check-tox` | Verify tox | `check-python` |
| `check-molecule` | Verify molecule | `check-python`, `check-docker` |
| `check-linters` | Verify all linting tools | (individual linter checks) |
| `check-tests` | Verify testing tools | (individual test tool checks) |
| `check-tools` | Verify required tools | `check-git`, `check-python`, `check-ansible`, `check-pyenv`, `check-uv`, `check-docker`, `check-make` |
| `env-check` | Run all environment checks | (all check-* targets) |
| `ee-check` | Check Docker environment | `check-docker` |
| `ee-build` | Build execution environment | `check-docker` |
| `ee-clean` | Clean execution environment images | - |
| `ee-lint` | Run linters in the execution environment | - |
| `ee-shell` | Start a shell in the execution environment | - |


### Development

| Target | Description |
|--------|-------------|
| `docs` | Generate documentation |
| `env` | Set up development environment |
| `help` | Show this help message |
| `status` | Show project status |
| `sync` | Sync with remote repository (git rebase) |
| `version` | Show project version |
| `watch` | Watch for changes and run tests |

## Execution Environment

The project uses containerized execution environments for consistent development and testing. The following targets manage the execution environment:

| Target | Description | Dependencies |
|--------|-------------|--------------|
| `ee-build` | Build the execution environment image | `check-container-runtime`, `check-ansible-builder` |
| `ee-test` | Run tests in the execution environment | `ee-build` |
| `ee-lint` | Run linters in the execution environment | `ee-build` |
| `ee-shell` | Get a shell in the execution environment | `ee-build` |
| `ee-clean` | Clean execution environment images | - |

## Deployment

These targets handle deployment to different environments:

| Target | Description | Dependencies |
|--------|-------------|--------------|
| `deploy` | Deploy to development environment (alias for deploy-dev) | - |
| `deploy-dev` | Deploy to development environment | `build` |
| `deploy-prod` | Deploy to production environment | `check_prod_branch`, `check_galaxy_token`, `build` |
| `dev-beta` | Build and test for beta deployment | `build`, `test` |

## Helper/Utility Targets

These targets provide additional functionality and checks:

| Target | Description | Dependencies |
|--------|-------------|--------------|
| `check-container-runtime` | Verify container runtime (Docker/Podman) is available | - |
| `check-ansible-builder` | Verify ansible-builder is installed | - |
| `git-check-clean-publish` | Verify git working directory is clean before publishing | - |
| `git-check-clean-dev` | Verify git working directory is clean for development | - |
| `git-tag-beta` | Create beta version tag | - |
| `git-tag-prod` | Create production version tag | - |

### Development Workflow

| Target | Description | Dependencies |
|--------|-------------|--------------|
| `all` | Build and test all collections (default) | `env-check`, `build`, `test` |
| `build` | Build all collections | `check-tools` |
| `clean` | Remove build artifacts | - |
| `lint` | Run all linters | (all lint-* targets) |
| `lint-ansible` | Lint Ansible content | `check-ansible-lint` |
| `lint-markdown` | Lint Markdown files | `check-markdownlint` |
| `lint-yaml` | Lint YAML files | `check-yamllint` |
| `lint-galaxy` | Lint galaxy.yml files | `check-flake8` |
| `debug` | Show debug information about the project | - |
| `env` | Show development environment information | - |
| `sync` | Sync with remote repository (git pull --rebase) | - |
| `watch` | Watch for file changes and rebuild | - |
| `new-module` | Create a new module | - |
| `new-role` | Create a new role in a collection | - |
| `reset` | Reset all markers to force full rebuild | - |
| `release` | Create a new release | - |

## Installation Methods

This project provides several ways to install collections, each suitable for different use cases. All installation methods are available as Makefile targets in `ansible-galaxy/Makefile` and as individual scripts in `ansible-galaxy/bin/`.

### Available Installation Methods

1. **From Source**
   - **Use case**: Development and testing of local changes
   - **Make target**: `make inst-src [collection1 collection2 ...]`
   - **Script**: `./bin/install-from-src.sh [collection1 collection2 ...]`
   - **Description**: Installs collections directly from the source directories. This is the fastest way to test local changes without building or publishing.

2. **From Git Repository**
   - **Use case**: Installing from a specific branch or tag
   - **Make target**: `make inst-repo [branch] [collection1 collection2 ...]`
   - **Script**: `./bin/install-from-repo.sh [branch] [collection1 collection2 ...]`
   - **Description**: Clones the repository (or a specific branch) and installs collections from it. Useful for testing changes from a feature branch or specific version.

3. **From Build Artifacts**
   - **Use case**: Testing built collections before publishing
   - **Make target**: `make inst-build [collection1 collection2 ...]`
   - **Script**: `./bin/install-from-build.sh [collection1 collection2 ...]`
   - **Description**: Installs collections from the built artifacts in the `dist/` directory. This verifies that the built packages work as expected.

4. **From Beta Server**
   - **Use case**: Testing collections in a staging environment
   - **Make target**: `make inst-beta [collection1 collection2 ...]`
   - **Script**: `./bin/install-from-beta.sh [collection1 collection2 ...]`
   - **Description**: Installs collections from the beta server (galaxy-dev.ansible.com). Requires authentication if the collections are not public.

5. **From Production Server**
   - **Use case**: Production deployment
   - **Make target**: `make inst-prod [collection1 collection2 ...]`
   - **Script**: `./bin/install-from-prod.sh [collection1 collection2 ...]`
   - **Description**: Installs collections from the production Ansible Galaxy server (galaxy.ansible.com).

### Examples

```bash
# Install all collections from source (development)
make inst-src

# Install specific collections from source
make inst-src common gamer

# Install all collections from a specific git branch
make inst-repo feature/new-feature

# Install specific collections from build artifacts
make inst-build base_system user_setup

# Install all collections from beta server
make inst-beta

# Install specific collections from production
make inst-prod common base_system
```

### Configuration

For server-based installations (beta/production), you may need to set up authentication:

1. Get your API token from [Ansible Galaxy](https://galaxy.ansible.com/me/preferences)
2. Set the token as an environment variable:
   ```bash
   export ANSIBLE_GALAXY_TOKEN=your_token_here
   ```

### Testing After Installation

All installation methods will automatically run any available test playbooks after installation. Test playbooks should be named following these conventions:
- Collection-specific: `tests/test-levonk.{collection_name}.yml`
- Namespace-wide: `tests/test-levonk.yml`

## Publishing Collections

### Publish to Beta Server

Publish collections to the beta server for testing:

```bash
make beta
```

### Publish to Production

Publish collections to the production Ansible Galaxy server:

```bash
make prod
```

## Local Development

### CLI Method for Testing

For one-off testing without installation, you can tell Ansible to use a specific collections path:

```bash
ansible-playbook your_playbook.yml -c {repo-root}/ansible-galaxy/collections/
```

### Modify Your ansible.cfg

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



## README.md TODO

### Build System Requirements

#### Containerized Development Environment
- Docker Engine 20.10+
- Docker Compose 2.0+
- Git

#### Container Architecture
1. **Base Environment** (Debian-based)
2. **Build Environment** (extends Base)
3. **Runtime Environment** (extends Base)

#### Key Directories
- `/ansible-galaxy/bin/` - Executable scripts
- `/ansible-galaxy/collections/ansible_collections/levonk/` - Collections
- `/ansible-galaxy/dist/` - Built artifacts
- `/ansible-galaxy/.markers/` - Build state tracking

#### Build Process
- Uses a Makefile for automation
- Collections are built into `.tar.gz` artifacts
- Supports incremental builds using marker files

#### Development Workflow
1. Build containers: `docker compose build`
2. Start environment: `docker compose up -d`
3. Access build container: `docker compose exec builder bash`

The project emphasizes containerization for development consistency and uses Make for build automation. The build system is designed to be self-contained within Docker containers to ensure consistent environments across development, testing, and production.

### Identified Issues and Improvements

#### Inconsistencies
1. **Script Naming**
   - The repository structure shows `publish-*.sh` and `install-*.sh` with wildcards, but actual script names aren't consistently documented
   - Scripts in `bin/` are mentioned in the structure but not fully documented in usage sections

2. **Makefile Targets**
   - Incomplete documentation of targets in "Makefile Reference" and "Available Targets" sections
   - Undocumented targets in mermaid diagrams (e.g., `ee-clean`, `env-check`)

3. **Version Requirements**
   - Missing specifications for:
     - Minimum Python version
     - Ansible version requirements
     - Hardware requirements

4. **Development Workflow**
   - No clear guidance on:
     - Adding new collections
     - Updating existing collections
     - Handling collection dependencies

5. **Documentation Structure**
   - Truncated "Makefile Reference" section
   - Some duplicated or inconsistently formatted sections

#### Unanswered Questions

##### Testing
- How to run tests for individual collections?
- What's the testing strategy (unit tests, integration tests, etc.)?

##### Versioning
- What versioning scheme is used for collections?
- How are version bumps handled?

##### Dependencies
- How are inter-collection dependencies managed?
- How are external dependencies specified?

##### Documentation
- How is documentation generated?
- Where should documentation for individual collections live?

##### Contributing
- Are there contribution guidelines?
- What's the process for submitting changes?

##### Troubleshooting
- Common issues and their solutions
- How to debug build failures

##### CI/CD
- Is there a CI/CD pipeline?
- What are the deployment targets?

