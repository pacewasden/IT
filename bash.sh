#!/bin/bash

# Get a list of installed applications
app_list=$(system_profiler SPApplicationsDataType | grep -E '^\s{4}[A-Za-z]' | awk -F ": " '{print $NF}')

# Loop through each application and get its version
for app_name in $app_list
do
    version=$(mdls -name kMDItemVersion "/Applications/${app_name}" 2>/dev/null | awk -F'\"' '/kMDItemVersion/{print $4}')
    if [ -z "$version" ]; then
        version="Version information not found"
    fi
    echo "Application: $app_name | Version: $version"
done

