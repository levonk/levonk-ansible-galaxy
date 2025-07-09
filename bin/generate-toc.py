#!/usr/bin/env python3
# Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
# See LICENSE file in the project root for full license information.
"""
Generate a table of contents for the documentation.

This script scans the documentation directory and generates a markdown TOC.
"""

import os
from pathlib import Path

def get_markdown_files(directory):
    """Recursively find all markdown files in the given directory."""
    markdown_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.md') and not file.startswith('.'):
                rel_path = os.path.relpath(os.path.join(root, file), directory)
                markdown_files.append(rel_path)
    return sorted(markdown_files)

def format_toc_entry(file_path, base_level=2):
    """Format a single TOC entry from a file path."""
    # Remove .md extension and replace _ with spaces
    title = os.path.splitext(os.path.basename(file_path))[0].replace('-', ' ').title()
    # Create relative link
    link = file_path.replace('\\', '/')
    # Create indentation based on directory depth
    indent = '  ' * (len(Path(file_path).parts) - 1)
    # Format as markdown list item
    return f"{indent}- [{title}]({link})"

def generate_toc(directory='.'):
    """Generate a markdown table of contents."""
    markdown_files = get_markdown_files(directory)
    
    # Group files by directory
    toc = {}
    for file_path in markdown_files:
        dir_path = os.path.dirname(file_path)
        if dir_path not in toc:
            toc[dir_path] = []
        toc[dir_path].append(file_path)
    
    # Generate TOC
    output = ["# Table of Contents\n"]
    
    # Root level files first
    if '' in toc:
        for file_path in toc['']:
            output.append(f"- [{os.path.splitext(file_path)[0].replace('-', ' ').title()}]({file_path.replace('\\\\', '/')})")
        output.append('')
    
    # Then subdirectories
    for dir_path in sorted(toc.keys()):
        if dir_path:  # Skip root, already handled
            output.append(f"## {dir_path.replace(os.path.sep, ' › ')}\n")
            for file_path in sorted(toc[dir_path]):
                output.append(f"- [{os.path.splitext(os.path.basename(file_path))[0].replace('-', ' ').title()}]({file_path.replace('\\\\', '/')})")
            output.append('')
    
    return '\n'.join(output)

if __name__ == '__main__':
    docs_dir = os.path.dirname(os.path.abspath(__file__))
    toc = generate_toc(docs_dir)
    print(toc)
    
    # Optionally write to a file
    with open(os.path.join(docs_dir, 'TOC.md'), 'w', encoding='utf-8') as f:
        f.write(toc)
