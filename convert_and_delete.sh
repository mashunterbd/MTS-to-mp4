#!/bin/bash

# Current directory where the script is executed
DIRECTORY=$(pwd)

# Loop through all .MTS files in the directory
for file in "$DIRECTORY"/*.MTS; do
    # Check if the file exists (in case there are no .MTS files)
    if [ -e "$file" ]; then
        # Extract the file name without the extension
        filename=$(basename -- "$file")
        filename="${filename%.*}"
        
        # Convert the .MTS file to .mp4
        ffmpeg -i "$file" -c:v copy -c:a copy "$DIRECTORY/$filename.mp4"
        
        # If conversion is successful, delete the original .MTS file
        if [ $? -eq 0 ]; then
            echo "Conversion successful for: $file"
            rm "$file"
        else
            echo "Conversion failed for: $file"
        fi
    fi
done
