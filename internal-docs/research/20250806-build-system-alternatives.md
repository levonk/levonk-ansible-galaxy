# Build System Alternatives for Ansible Galaxy Collections

## Current Challenges

- Maintaining hundreds of Makefiles throughout the directory tree
- Duplicated configuration and targets across many files
- Difficulty ensuring consistency across all Makefiles
- High maintenance burden when adding new targets or changing existing ones
- No centralized configuration like Git

## Recommended Alternatives

### Monorepo Build Systems

#### 1. Nx

**Strengths:**
- Designed specifically for monorepos with multiple projects
- Automatic dependency detection between projects
- Incremental builds that only rebuild what's affected by changes
- Sophisticated caching system to avoid redundant work
- Visual dependency graph of projects
- Extensible plugin system

**Example Configuration:**
```json
{
  "npmScope": "levonk",
  "affected": {
    "defaultBase": "main"
  },
  "tasksRunnerOptions": {
    "default": {
      "runner": "nx/tasks-runners/default",
      "options": {
        "cacheableOperations": ["build", "test", "lint"]
      }
    }
  },
  "targetDefaults": {
    "build": {
      "dependsOn": ["^build"]
    },
    "test": {
      "dependsOn": ["build"]
    }
  }
}
```

#### 2. Pants

**Strengths:**
- Excellent Python support (relevant for Ansible)
- Fine-grained invalidation that only rebuilds what's necessary
- Built-in support for shell scripts
- Language support for Python, Java, Scala, Go, Shell, and more
- Extensible plugin system

**Example Configuration:**
```toml
[GLOBAL]
pants_version = "2.15.0"

[source]
root_patterns = [
  "ansible-galaxy/collections/ansible_collections/levonk/*",
]

[python]
interpreter_constraints = [">=3.8"]

[test]
timeout_seconds = 60
```

### Command Runners

#### 1. Just

**Strengths:**
- Git-like configuration discovery
- Simple, readable syntax
- Hierarchical configuration
- Good shell script integration
- Cross-platform support

**Example Configuration:**
```
# Define variables once
collection_dir := "ansible-galaxy/collections/ansible_collections"

# Define common recipes
build:
    ./bin/build.sh

test:
    ./bin/test.sh

# Run a command in all collections
all-collections command:
    find {{collection_dir}}/levonk -type d -name "galaxy.yml" -exec dirname {} \; | \
    xargs -I{} sh -c "cd {} && {{command}}"
```

#### 2. Task

**Strengths:**
- YAML-based configuration (familiar to Ansible users)
- Hierarchical task organization
- Cross-platform support
- Parallel execution
- Directory-based task execution

**Example Configuration:**
```yaml
version: '3'

vars:
  COLLECTIONS_DIR: ansible-galaxy/collections/ansible_collections/levonk

tasks:
  default:
    desc: Build and test all collections
    deps: [build, test]

  build:
    desc: Build all collections
    cmds:
      - ./bin/build.sh

  test:
    desc: Test all collections
    cmds:
      - ./bin/test.sh

  lint:
    desc: Run all linters
    cmds:
      - task: lint-ansible
      - task: lint-markdown
      - task: lint-yaml
```

## Implementation Strategy

1. **Start with Core Functionality:**
   - Implement the most common tasks first (build, test, lint)
   - Create a central configuration file at the repository root

2. **Gradual Migration:**
   - Convert one collection at a time, starting with the blueprint templates
   - Use the existing shell scripts in `/bin` as executors for the new build system

3. **Standardize Project Structure:**
   - Define consistent project structures for collections and roles
   - Create templates for new components

4. **Leverage Existing Scripts:**
   - Keep your existing shell scripts in `/bin`
   - Have the build system call these scripts rather than reimplementing functionality

## Next Steps

1. Select a preferred build system based on team familiarity and project needs
2. Create a proof of concept with one collection
3. Develop a migration plan for the entire repository
4. Update documentation and onboarding materials
