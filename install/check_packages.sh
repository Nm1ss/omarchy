#!/bin/bash

# Specify the file containing the packages to check
PACKAGE_FILE="omarchy-base.packages"

# Check if the package file exists
if [[ ! -f "$PACKAGE_FILE" ]]; then
  echo "Error: Package file '$PACKAGE_FILE' does not exist."
  exit 1
fi

# Read the package names from the file, ignoring empty lines and comments
mapfile -t packages < <(grep -v '^#' "$PACKAGE_FILE" | grep -v '^$')

# Get the list of currently installed packages using pacman
installed_packages=$(pacman -Qq)

# Loop through each package in the provided list and check if it's installed
for package in "${packages[@]}"; do
  if ! echo "$installed_packages" | grep -q "^$package$"; then
    echo "$package is NOT installed"
  fi
done
