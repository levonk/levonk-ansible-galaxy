# Docker Configuration

This directory contains Docker-related configurations and scripts for the project.

## Purpose

The Docker setup provides containerized environments for:
- Development
- Testing
- Building and packaging
- Running the Ansible collections

## Directory Structure

- `Dockerfile`: Base image definition
- `docker-compose.yml`: Service definitions and configurations
- `.env.example`: Example environment variables

## Usage

### Prerequisites
- Docker
- Docker Compose

### Starting the Environment
```bash
docker-compose up -d
```

### Accessing Containers
```bash
# Access the builder container
docker-compose exec builder bash

# Access the runtime container
docker-compose exec runtime bash
```

### Stopping the Environment
```bash
docker-compose down
```

## Development Workflow

1. Make changes to your code
2. Use the builder container to test and build
3. Test the built artifacts in the runtime container
4. Commit and push your changes

## Environment Variables

Copy `.env.example` to `.env` and adjust the values as needed.
