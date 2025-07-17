# Copyright (c) 2025 the person whos account is https://github.com/levonk. Licensed under the GNU AGPL-3.0 License. See LICENSE file in the project root for full license information.

<#
.SYNOPSIS
Runs Ansible development commands inside a Docker container.

.DESCRIPTION
This script simplifies running Ansible tools like ansible-lint and molecule by executing them within a pre-configured Docker container. It mounts the current directory into the container, ensuring that the tools operate on your local files.

.PARAMETER Command
The command to execute inside the Docker container (e.g., 'ansible-lint .', 'molecule test').

.EXAMPLE
./ansible-dev.ps1 "ansible-lint ."

.EXAMPLE
./ansible-dev.ps1 "molecule test -s default"
#>

param (
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Command
)

$imageName = "ansible-tools"
$fullCommand = $Command -join " "

Write-Host "Running command in Docker: $fullCommand"

docker run --rm -v "${PWD}:/workdir" -w /workdir $imageName -c "$fullCommand"
