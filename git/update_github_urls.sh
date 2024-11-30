#!/bin/bash

show_usage() {
    echo "Usage: $0 <old_username> <new_username>"
    echo "Example: $0 old_user new_user"
}

if [ "$#" -ne 2 ]; then
    echo "Error: Old username and new username are required"
    show_usage
    exit 1
}

OLD_USERNAME=$1
NEW_USERNAME=$2

# Process each Git repository
find . -type d -name ".git" | while read -r gitdir; do
    repo_dir=$(dirname "$gitdir")
    cd "$repo_dir" || continue
    
    current_url=$(git remote get-url origin 2>/dev/null)
    if [ $? -eq 0 ] && [[ $current_url == *"$OLD_USERNAME"* ]]; then
        # Determine URL type (HTTPS or SSH)
        if [[ $current_url == https://* ]]; then
            new_url=${current_url/$OLD_USERNAME/$NEW_USERNAME}
        else
            new_url=${current_url/:$OLD_USERNAME/:$NEW_USERNAME}
        fi
        
        echo "Updating: $current_url → $new_url"
        git remote set-url origin "$new_url"
        
        if [ $? -eq 0 ]; then
            echo "✓ Update successful"
        else
            echo "✗ Update failed"
        fi
    fi
    
    cd - > /dev/null
done

echo "Completed"