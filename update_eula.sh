#!/bin/bash

### Change EULA to true

# Define the filename
filename="EULA.txt"

# Check if the file exists
if [ -f "$filename" ]; then
    # Use sed to find and replace the value
    sed -i 's/EULA=false/EULA=true/g' "$filename"
    echo "EULA value changed to true."
else
    echo "File $filename does not exist."
    exit 1
fi