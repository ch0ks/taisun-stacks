###############################################################################
# Script Name: unsecure_files.sh
# Description: Decrypts files in the ../secured-env directory.
# Author: Adrian Puente Z. <apuente@hackarandas.com>
# Date: January 4, 2024
# Usage: ./unsecure_files.sh
###############################################################################

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
input_dir="../secured-env"    # Input directory containing encrypted files
output_dir="../"              # Output directory for decrypted files

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Iterate through .asc (encrypted) files in the input directory
for file in "$input_dir"/*.asc; do
  if [ -f "$file" ]; then
    # Get the filename without the path and extension
    filename=$(basename "$file" .asc)

    # Decrypt the .asc file using GPG and place the decrypted file in the output directory
    gpg --output "$output_dir/$filename" --decrypt "$file"

    # Optionally, you can remove the original .asc file if desired
    # rm "$file"
  fi
done

echo "Decryption complete. Decrypted files are in the $output_dir directory."
