#!/bin/bash

# Get the host name
hostname=$(hostname)

# Specify the directories where applications may be installed
app_directories=("/Applications" "$HOME/Applications" "/Applications")

# Flag to track whether any applications were found
found_apps=false

# Loop through each directory and each application
for directory in "${app_directories[@]}"; do
    if [ -d "$directory" ]; then
        applications=$(find "$directory" -maxdepth 1 -type d -name "*.app" -print 2>/dev/null)

        for app in $applications; do
            app_name=$(basename "$app")
            version=$(mdls -raw -name kMDItemVersion "$app" 2>/dev/null)
            
            if [ -n "$version" ]; then
                echo "$app_name: $version"
                found_apps=true
            fi
        done
    fi
done

# Omit printing "No applications found" if no applications were found
if [ "$found_apps" = false ]; then
    :
fi


# Check if no applications were found and print message
if [ "$found_apps" = false ]; then
    echo "No applications found."
fi
