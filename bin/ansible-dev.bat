@echo off
rem Copyright (c) 2025 the person whos account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.

rem.SYNOPSIS
rem Runs Ansible development commands inside a Docker container.

rem.DESCRIPTION
rem This script simplifies running Ansible tools like ansible-lint and molecule by executing them within a pre-configured Docker container. It mounts the current directory into the container, ensuring that the tools operate on your local files.

rem.PARAMETER Command
rem The command to execute inside the Docker container (e.g., 'ansible-lint .', 'molecule test').

rem.EXAMPLE
rem ansible-dev.bat "ansible-lint ."

rem.EXAMPLE
rem ansible-dev.bat "molecule test -s default"

rem --- SCRIPT ---

rem IMPORTANT: Replace 'your-ansible-dev-image:latest' with the actual Docker image name from your ansible-dev.ps1 script.
set DOCKER_IMAGE=your-ansible-dev-image:latest

echo Running command in Docker container: %DOCKER_IMAGE%
echo Command: %*

docker run --rm -it -v "%cd%:/data" -w /data %DOCKER_IMAGE% %*
