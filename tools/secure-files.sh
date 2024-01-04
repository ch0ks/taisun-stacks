#!/usr/bin/env bash

# Define the expected directory name
expected_directory="tools"

# Get the current directory
current_directory=$(basename "$PWD")

# Check if the script is running within the expected directory
if [ "$current_directory" != "$expected_directory" ]; then
  echo "Error: This script must be run from the $expected_directory directory."
  exit 1
fi

# Define the input and output directories
input_dir="../"                # Parent directory
output_dir="../secured-env"    # Output directory for encrypted files

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Iterate through .env files in the input directory
for file in "$input_dir"/*.env; do
  if [ -f "$file" ]; then
    # Get the filename without the path and extension
    filename=$(basename "$file" .env)

    # Check if an encrypted file with the same name already exists
    if [ -f "$output_dir/$filename.asc" ]; then
      # Create a backup of the existing .asc file with a timestamp
      timestamp=$(date +"%Y%m%d%H%M%S")
      mv "$output_dir/$filename.asc" "$output_dir/$filename-$timestamp.asc"
    fi

    # Encrypt the .env file using GPG with ASCII armor and the specified recipient key
    gpg --output "$output_dir/$filename.asc" --armor --encrypt --recipient 0x6326DB03A60495D7 "$file"

    # Optionally, you can remove the original .env file if desired
    # rm "$file"
  fi
done

echo "Encryption complete. Encrypted files are in the $output_dir directory."
