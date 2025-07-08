# Creating a New Collection from Template

This guide explains how to create a new Ansible collection by duplicating the template directory. The template provides a standardized structure with all necessary configuration files and directories.

## Prerequisites

- Git installed
- Python 3.8 or later
- Ansible installed
- Access to the repository

## Step 1: Navigate to the Collections Directory

```bash
cd shared-deployment/cfg-management/ansible/gh/levonk/levonk-ansible-galaxy/levonk
```

## Step 2: Duplicate the Template

Run the following command, replacing `your-collection-name` with your desired collection name (lowercase, hyphenated):

```bash
cp -r template your-collection-name
```

## Step 3: Update Collection Metadata

Edit the `galaxy.yml` file in your new collection directory:

```bash
cd your-collection-name
nano galaxy.yml
```

Update the following fields:
- `namespace`: Keep as `levonk`
- `name`: Your collection name (e.g., `your_collection_name`)
- `version`: Start with `1.0.0`
- `readme`: Update to match your collection
- `authors`: Add your name and email
- `description`: Brief description of your collection
- `repository`: Update the repository URL
- `documentation`: Update the documentation URL
- `homepage`: Update the homepage URL
- `issues`: Update the issues URL
- `tags`: Update with relevant tags
- `license`: Update if needed

## Step 4: Update Documentation

1. Rename the `docs/` directory to match your collection name:
   ```bash
   mv docs/ your_collection_name/
   ```

2. Update the documentation files in `your_collection_name/docs/`:
   - Update `index.md` with your collection's documentation
   - Update any other documentation files as needed

## Step 5: Update Role Structure (If Needed)

If your collection includes roles:

1. Navigate to the roles directory:
   ```bash
   cd roles/
   ```

2. For each role:
   - Update the `meta/main.yml` file with role-specific information
   - Update the `README.md` file with role documentation
   - Update any task files with your specific tasks

## Step 6: Update Plugins (If Needed)

If your collection includes custom plugins:

1. Navigate to the plugins directory:
   ```bash
   cd plugins/
   ```

2. Update the plugin files with your custom plugin code
3. Update the `docs/plugins/` documentation

## Step 7: Update Tests

1. Navigate to the tests directory:
   ```bash
   cd tests/
   ```

2. Update the test files with your specific test cases
3. Update the `molecule/` directory with your test scenarios

## Step 8: Update .gitignore

Review and update the `.gitignore` file to exclude any unnecessary files:

```
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Unit test / coverage reports
htmlcov/
.tox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/
```

## Step 9: Initialize Git Repository

```bash
git init
git add .
git commit -m "Initial commit"
```

## Step 10: Push to Remote Repository

1. Create a new repository on your Git hosting service (GitHub, GitLab, etc.)
2. Add the remote repository:
   ```bash
   git remote add origin <repository-url>
   ```
3. Push your code:
   ```bash
   git push -u origin main
   ```

## Step 11: Build and Publish

1. Install the build tools:
   ```bash
   pip install --upgrade build
   ```

2. Build the collection:
   ```bash
   ansible-galaxy collection build .
   ```

3. Publish to Ansible Galaxy (if applicable):
   ```bash
   ansible-galaxy collection publish <path-to-tar-gz>
   ```

## Step 12: Update Documentation

Update the main `README.md` with information about your new collection, including:
- Purpose of the collection
- Installation instructions
- Usage examples
- Requirements
- License information

## Step 13: Create a Release

1. Create a tag for your release:
   ```bash
   git tag -a v1.0.0 -m "Initial release"
   git push origin v1.0.0
   ```

2. Create a release on your Git hosting service with release notes

## Step 14: Update Dependencies

If your collection depends on other collections, update the `meta/collection-requirements.yml` file:

```yaml
---
collections:
  - name: namespace.collection_name
    version: 1.0.0
    source: https://galaxy.ansible.com
```

## Step 15: Test Installation

Test installing your collection in a clean environment:

```bash
ansible-galaxy collection install git+https://github.com/your-username/your-collection-name.git
```

## Troubleshooting

- If you encounter permission issues, ensure you have the necessary permissions to create files and directories
- If the collection doesn't build, check the `galaxy.yml` file for syntax errors
- If tests fail, review the test output and update your code accordingly

## Best Practices

1. Keep your collection focused on a specific purpose
2. Follow semantic versioning for releases
3. Write comprehensive documentation
4. Include tests for all functionality
5. Use meaningful commit messages
6. Keep your dependencies up to date
7. Follow Ansible's code style guidelines

## Next Steps

- Add more roles and plugins as needed
- Write integration tests
- Set up CI/CD for automated testing and deployment
- Document your collection in the main documentation

## Support

For support, please open an issue in the repository or contact the maintainers.
