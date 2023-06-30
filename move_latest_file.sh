#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Latest Download to Directory
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Search Input" }

# Source the configuration file
# The file contains the ONEDRIVE_DIR environment variable. Example: 
# export ONEDRIVE_DIR="/Users/currentuser/Library/Group\\ Containers/UBF8T346G9.OneDriveStandaloneSuite/OneDrive.noindex/OneDrive"
source "$(dirname "$0")/config.sh"

# Set the source directory
src_dir="$HOME/Downloads"

# Search input for the destination directory
search_input="$1"

echo "Search input: $search_input" # Debug print

# Find the destination directory based on the search input
dest_dir=$(find "$ONEDRIVE_DIR" -type d -iname "*$search_input*" -print -quit)

echo "Destination directory: $dest_dir" # Debug print

# Check if the destination directory exists
if [[ -n $dest_dir ]]; then
    # Find the latest file
    latest_file=$(ls -t $src_dir | head -n 1)

    echo "Latest file: $latest_file" # Debug print

    # Check if file is not empty
    if [[ -n $latest_file ]]; then
        # Move the latest file
        osascript -e "tell application \"Finder\" to move POSIX file \"$src_dir/$latest_file\" to POSIX file \"$dest_dir\""
        echo "Moved $latest_file to $dest_dir"
    else
        echo "No files found in $src_dir"
    fi
else
    echo "No directory found for search input: $search_input"
fi
