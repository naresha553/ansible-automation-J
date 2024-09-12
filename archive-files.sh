#!/bin/bash

# Variables
source_dir="/var/tmp/TEST"  # Directory containing the files/folders to be archived
archive_dir="/var/tmp/XYZ11"  # Destination directory for archived files/folders

# Check if the archive directory exists; if not, create it
if [ ! -d "$archive_dir" ]; then
  mkdir -p "$archive_dir"
fi

# Find and move files older than 15 days along with their directory structure to the archive directory
find "$source_dir" -type f -mtime +15 -exec bash -c '
  file="{}"
  relative_dir=$(dirname "${file#${0}/}")
  echo $relative_dir
  echo "============"
  echo $file
  mkdir -p "$1/$relative_dir"
  mv "$file" "$1/$relative_dir"
' "$source_dir" "$archive_dir" \;

echo "Archiving completed."
