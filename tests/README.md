# Test Suite

This directory contains the test suite for the Ansible collections and roles in this repository.

## Directory Structure

- `integration/`: Integration tests for collections and roles
  - `targets/`: Test playbooks for specific components
- `sanity/`: Sanity tests for basic functionality

## Running Tests

### Running All Tests
```bash
bun run test
```

### Running Specific Tests
```bash
# Run integration tests
bun run test:integration

# Run sanity tests
bun run test:sanity
```

## Writing Tests

### Integration Tests
1. Create a new directory under `tests/integration/targets/` for your component
2. Add test playbooks with the `.yml` extension
3. Include necessary test data and fixtures

### Sanity Tests
1. Add test files to the `tests/sanity/` directory
2. Follow existing patterns for test structure
3. Ensure tests are idempotent where possible

## Best Practices

- Keep tests focused and independent
- Use meaningful test names
- Include assertions to verify expected outcomes
- Clean up any test resources after execution
- Document any test dependencies or setup requirements
