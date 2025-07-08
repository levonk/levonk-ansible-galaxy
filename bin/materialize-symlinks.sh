#!/bin/bash
# Copyright (c) 2025 the owner of https://github.com/levonk. Licensed under the GNU AGPL-3.0 License.
# See LICENSE file in the project root for full license information.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variables
TEMP_BRANCH=""
STASHED_CHANGES=0
REPLACED_FILES=()
SKIPPED_FILES=()
HAS_GIT=0
IS_GIT_REPO=0

# Function to display help
show_help() {
    echo "Usage: $0 [options]"
    echo "Convert symlinks in the current directory and its subdirectories to regular files."
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message and exit"
    echo ""
    echo "This script will:"
    echo "1. Check for uncommitted changes"
    echo "2. Verify you're not on a protected branch"
    echo "3. Find all symlinks in the directory tree"
    echo "4. Replace valid symlinks with their target files"
    echo "5. Report any broken symlinks"
    exit 0
}

# Check for help flag
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_help
fi

# Function to prompt user for confirmation
prompt_continue() {
    local message="$1"
    local options="$2"
    local choice
    
    while true; do
        read -p "$message [$options] " choice
        case $choice in
            [Pp]* ) return 0;;
            [Aa]* ) echo "Operation aborted by user."; exit 1;;
            [Cc]* ) 
                if [[ "$options" == *"C"* ]]; then 
                    return 2
                fi
                ;;
            [Ss]* ) 
                if [[ "$options" == *"S"* ]]; then 
                    return 3
                fi
                ;;
            * ) echo "Please enter a valid option.";;
        esac
    done
}

# First, check if there are any symlinks to process
SYMLINKS=()
while IFS= read -r -d '' link; do
    SYMLINKS+=("$link")
done < <(find . -type l -print0)

if [ ${#SYMLINKS[@]} -eq 0 ]; then
    echo -e "${GREEN}No symlinks found in the current directory tree. Nothing to do.${NC}"
    exit 0
fi

# Check for broken symlinks
BROKEN_LINKS=()
VALID_LINKS=()

for link in "${SYMLINKS[@]}"; do
    if [ ! -e "$link" ]; then
        BROKEN_LINKS+=("$link")
    else
        VALID_LINKS+=("$link")
    fi
done

# Report broken symlinks
if [ ${#BROKEN_LINKS[@]} -gt 0 ]; then
    echo -e "${YELLOW}The following symlinks are broken:${NC}"
    for link in "${BROKEN_LINKS[@]}"; do
        echo -e "  ${RED}$link${NC}"
    done
    
    # Ask user what to do with broken links
    prompt_continue "Do you want to [S]kip these broken links or [A]bort?" "S/A"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Operation aborted by user.${NC}"
        exit 1
    fi
    
    # Add broken links to skipped files
    for link in "${BROKEN_LINKS[@]}"; do
        SKIPPED_FILES+=("$link")
    done
    echo -e "${YELLOW}Broken links will be skipped.${NC}\n"
fi

# If no valid symlinks remain, exit
if [ ${#VALID_LINKS[@]} -eq 0 ]; then
    echo -e "${YELLOW}No valid symlinks found to process.${NC}"
    exit 0
fi

# Check permissions for valid symlinks
PERMISSION_ISSUES=0
declare -A checked_dirs  # Track directories we've already checked

for link in "${VALID_LINKS[@]}"; do
    # Check read permission on the symlink itself
    if [ ! -r "$link" ]; then
        echo -e "${RED}No read permission on: $link${NC}"
        PERMISSION_ISSUES=1
        continue
    fi
    
    # Check write permission on the parent directory (only once per directory)
    link_dir=$(dirname "$link")
    if [ -z "${checked_dirs[$link_dir]}" ]; then
        if [ ! -w "$link_dir" ]; then
            echo -e "${RED}No write permission in directory: $link_dir${NC}"
            PERMISSION_ISSUES=1
        fi
        checked_dirs["$link_dir"]=1
    fi
    
    # Check if we can delete the symlink
    if [ ! -w "$link" ] && [ ! -L "$link" ]; then
        echo -e "${RED}No write permission to modify: $link${NC}"
        PERMISSION_ISSUES=1
    fi
done

# Handle permission issues
if [ $PERMISSION_ISSUES -ne 0 ]; then
    echo -e "${YELLOW}There are permission issues that need to be resolved.${NC}"
    prompt_continue "Do you want to [P]roceed anyway, [M]ake files writeable, or [A]bort?" "P/M/A"
    result=$?
    
    if [ $result -eq 1 ]; then  # Abort
        echo -e "${RED}Operation aborted due to permission issues.${NC}"
        exit 1
    elif [ $result -eq 2 ]; then  # Make writeable
        echo -e "${YELLOW}Attempting to make files writeable...${NC}"
        for link in "${VALID_LINKS[@]}"; do
            # Make parent directory writeable
            link_dir=$(dirname "$link")
            if [ ! -w "$link_dir" ]; then
                chmod u+w "$link_dir" 2>/dev/null || echo -e "${RED}Failed to make directory writeable: $link_dir${NC}"
            fi
            # Make the symlink writeable
            if [ ! -w "$link" ]; then
                chmod u+w "$link" 2>/dev/null || echo -e "${RED}Failed to make file writeable: $link${NC}"
            fi
        done
        echo -e "${GREEN}✓ Files made writeable. Proceeding...${NC}\n"
    fi
fi

# Check if git is installed first
if ! command -v git >/dev/null 2>&1; then
    # Git is not installed
    echo -e "\n${RED}[WARNING] Git is not installed. Version control is highly recommended.${NC}"
    
    while true; do
        read -p "[P]roceed without git, [I]nstall git, or [A]bort? " choice
        case $choice in
            [Pp]* )
                echo -e "${YELLOW}Proceeding without version control...${NC}"
                break
                ;;
            [Ii]* )
                echo -e "${GREEN}Installing git...${NC}"
                # Detect package manager and install git
                if command -v apt-get >/dev/null 2>&1; then
                    echo "Detected Debian/Ubuntu system. Running apt update first..."
                    sudo apt-get update && sudo apt-get install -y git
                elif command -v yum >/dev/null 2>&1; then
                    echo "Detected RHEL/CentOS system. Installing git..."
                    sudo yum install -y git
                elif command -v brew >/dev/null 2>&1; then
                    echo "Detected macOS with Homebrew. Installing git..."
                    brew install git
                else
                    echo -e "${RED}Could not detect package manager. Please install git manually.${NC}"
                    echo "Debian/Ubuntu: sudo apt-get update && sudo apt-get install git"
                    echo "RHEL/CentOS: sudo yum install git"
                    echo "macOS: brew install git"
                    echo "Windows: https://git-scm.com/download/win"
                    exit 1
                fi
                
                # Verify git installation
                if command -v git >/dev/null 2>&1; then
                    echo -e "${GREEN}✓ Git successfully installed.${NC}"
                    HAS_GIT=1
                    # Continue with the script
                else
                    echo -e "${RED}Git installation failed. Please install git manually.${NC}"
                    exit 1
                fi
                ;;
            [Aa]* )
                echo -e "${RED}Operation aborted by user.${NC}"
                exit 1
                ;;
            * )
                echo -e "${YELLOW}Please enter P, I, or A.${NC}"
                ;;
        esac
    done
else
    HAS_GIT=1
    
    # Now check if we're in a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        IS_GIT_REPO=1
    else
        echo -e "\n${RED}[WARNING] Not operating from git repository to allow revert.${NC}"
        echo -e "${YELLOW}It's highly recommended to use version control for these operations.${NC}"
        
        while true; do
            read -p "[P]roceed, [I]nit repository and commit, or [A]bort? " choice
            case $choice in
                [Pp]* ) 
                    echo -e "${YELLOW}Proceeding without version control...${NC}"
                    break
                    ;;
                [Ii]* ) 
                    echo -e "${GREEN}Initializing git repository...${NC}"
                    git init
                    git add .
                    git commit -m "Initial commit before materializing symlinks"
                    # Create a temporary branch with random name
            TEMP_BRANCH="temp/materialize-symlinks-$(date +%s)"
                    git checkout -b "$TEMP_BRANCH"
                    echo -e "${GREEN}✓ Repository initialized and temporary branch '$TEMP_BRANCH' created.${NC}"
                    IS_GIT_REPO=1
                    break
                    ;;
                [Aa]* ) 
                    echo -e "${RED}Operation aborted by user.${NC}"
                    exit 1
                    ;;
                * ) 
                    echo -e "${YELLOW}Please enter P, I, or A.${NC}"
                    ;;
            esac
        done
    fi
fi

# Only run git-specific checks if we're in a git repository
if [ $IS_GIT_REPO -eq 1 ]; then
    # Check for uncommitted changes first
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo -e "${YELLOW}You have uncommitted changes.${NC}"
        prompt_continue "Do you want to [P]roceed, [S]tash changes, [C]ommit changes, or [A]bort?" "P/S/C/A"
        result=$?
        
        if [ $result -eq 0 ]; then
            echo -e "${YELLOW}Proceeding with uncommitted changes...${NC}"
        elif [ $result -eq 2 ]; then # Commit
            echo -e "${GREEN}Committing changes...${NC}"
            git add .
            git commit -m "chore: auto-commit before materializing symlinks [$(date +'%Y-%m-%d %H:%M:%S')]"
            echo -e "${GREEN}✓ Changes have been committed.${NC}"
        elif [ $result -eq 3 ]; then # Stash
            echo -e "${GREEN}Stashing changes...${NC}"
            git stash push -m "Temporary stash before materializing symlinks [$(whoami) @ $(date +'%Y-%m-%d %H:%M:%S')]"
            STASHED_CHANGES=1
        else
            exit 1
        fi
    fi

    # Check current branch after handling any uncommitted changes
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$CURRENT_BRANCH" == "master" ]] || [[ "$CURRENT_BRANCH" == "envDev" ]] || [[ "$CURRENT_BRANCH" == "envProd" ]]; then
        echo -e "${YELLOW}Warning: You are on the '$CURRENT_BRANCH' branch.${NC}"
        prompt_continue "Do you want to [P]roceed, create a [T]emp branch, or [A]bort?" "P/T/A"
        result=$?
        
        if [ $result -eq 0 ]; then
            echo -e "${YELLOW}Proceeding on $CURRENT_BRANCH branch...${NC}"
        elif [ $result -eq 2 ]; then
            TEMP_BRANCH="temp/materialize-symlinks-$(date +%s)"
            echo -e "${GREEN}Creating temporary branch: $TEMP_BRANCH${NC}"
            git checkout -b "$TEMP_BRANCH"
        else
            exit 1
        fi
    fi
fi

# We already found and processed the symlinks at the beginning of the script
# Now process the valid symlinks we found earlier

# Show valid symlinks that will be replaced
if [ ${#VALID_LINKS[@]} -gt 0 ]; then
    echo -e "${GREEN}The following symlinks will be converted to regular files:${NC}"
    for link in "${VALID_LINKS[@]}"; do
        echo -e "  ${GREEN}$link${NC} -> $(readlink "$link")"
    done
    echo ""
    
    # Ask for confirmation before proceeding
    prompt_continue "Do you want to [P]roceed or [A]bort?" "P/A"
    if [ $? -ne 0 ]; then
        exit 1
    fi
    
    # Process valid symlinks
    for link in "${VALID_LINKS[@]}"; do
        # Skip if the link no longer exists (could have been modified by previous operations)
        if [ ! -L "$link" ] && [ ! -e "$link" ]; then
            echo -e "${YELLOW}Skipping missing file: $link${NC}"
            continue
        fi
        
        # Save the original permissions
        if [ -e "$link" ]; then
            perms=$(stat -c "%a" "$link" 2>/dev/null || stat -f "%Lp" "$link" 2>/dev/null)
            owner=$(stat -c "%U" "$link" 2>/dev/null || stat -f "%Su" "$link" 2>/dev/null)
            group=$(stat -c "%G" "$link" 2>/dev/null || stat -f "%Sg" "$link" 2>/dev/null)
        fi
        
        # Get the target of the symlink
        target=$(readlink "$link")
        
        # Skip if target doesn't exist
        if [ ! -e "$target" ]; then
            echo -e "${YELLOW}Skipping broken symlink: $link -> $target${NC}"
            continue
        fi
        
        # Remove the symlink
        rm -f "$link"
        
        # Copy the target file to the symlink location, preserving attributes
        cp -p "$target" "$link"
        
        # Restore original permissions if we could read them
        if [ -n "$perms" ] && [ -e "$link" ]; then
            chmod "$perms" "$link" 2>/dev/null || true
            # Only try to change owner/group if we're root or the file owner
            if [ "$(id -u)" -eq 0 ] || [ "$(whoami)" = "$owner" ]; then
                chown "$owner:$group" "$link" 2>/dev/null || true
            fi
        fi
        
        echo -e "${GREEN}✓ Replaced: $link (preserved permissions: $perms)${NC}"
    done
fi

# Print summary
echo -e "\n${GREEN}=== Operation Summary ===${NC}"

# Show replaced files
if [ ${#REPLACED_FILES[@]} -gt 0 ]; then
    echo -e "\n${GREEN}Successfully replaced ${#REPLACED_FILES[@]} symlinks:${NC}"
    for file in "${REPLACED_FILES[@]}"; do
        echo -e "  ${GREEN}✓ $file${NC}"
    done
fi

# Show skipped files
if [ ${#SKIPPED_FILES[@]} -gt 0 ]; then
    echo -e "\n${YELLOW}Skipped ${#SKIPPED_FILES[@]} files (broken symlinks or errors):${NC}"
    for file in "${SKIPPED_FILES[@]}"; do
        echo -e "  ${YELLOW}⚠ $file${NC}"
    done
fi

# Cleanup
if [ -n "$TEMP_BRANCH" ]; then
    echo -e "\n${YELLOW}You are on a temporary branch: $TEMP_BRANCH${NC}"
    echo -e "To switch back to your original branch and delete the temporary branch, run:"
    echo -e "  git checkout $CURRENT_BRANCH"
    echo -e "  git branch -D $TEMP_BRANCH"
elif [ $STASHED_CHANGES -eq 1 ]; then
    echo -e "\n${YELLOW}Changes were stashed during this operation.${NC}"
    echo -e "To restore your stashed changes after you switch back to your original branch, run:"
    echo -e "  git stash pop"
fi

echo -e "\n${GREEN}Operation completed successfully!${NC}"

exit 0
done