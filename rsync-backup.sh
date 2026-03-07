#!/bin/bash
cd "$(dirname "$0")"
pwd
# Do NOT include parenthesis or a trailing backslash in the source_folders.txt
DESTINATION="/Volumes/Backup" # Change this according to your backup drive
SOURCE_LIST="source_folders.txt" # Go into the .txt to change the sources
LOG_FILE="transfers.log"

#Verify source list file exists
if [ ! -f "$SOURCE_LIST" ]; then
    echo "Error: $SOURCE_LIST does not exist." >&2
    echo "Create the file, or edit the file path, and try again."
    exit 1
fi

#Verify destination exists
if [ ! -d "$DESTINATION" ]; then
    echo "ERROR: Destination ($DESTINATION) does not exist."
    echo "Connect the device, or edit the destination path, and try again."
    exit 1
fi

#Verify log file exists
if [ ! -d "$LOG_FILE" ]; then
    touch transfers.log
    echo "Error: No log file\n -> Created new log file"
fi

#Check if source list is empty
if [ ! -s "$SOURCE_LIST" ]; then
    echo "Error: $SOURCE_LIST is empty." >&2
    echo "Add source directories to the file, and try again."
    exit 1
fi


echo "---- BACKUP SESSION START ----" >> $LOG_FILE
echo "Starting..."
#Begin reading source list line-by-line, excluding blank lines and comment lines (starting with #)
while IFS= read -r source_dir || [ -n "$source_dir" ]
do
    # Skip empty lines and comments
    if [[ -z "$source_dir" || "$source_dir" =~ ^# ]]; then
        continue
    fi
    
    echo "-- Start: $(date) - On: $source_dir" >> $LOG_FILE
    echo "> ---- Start: $(date) - On: $source_dir"
    rsync -a --stats "$source_dir" "$DESTINATION/" | awk '
    /Number of files transferred/ {print "Files transferred: " $5}
    /Total transferred file size/ {print "Total size (bytes): "$5}
    ' >> $LOG_FILE

    rsync -azh "$source_dir" "$DESTINATION/"

    echo "-- End: $(date)" >> $LOG_FILE
    echo >> $LOG_FILE
    echo "---- Done ----"
    echo
done < "$SOURCE_LIST"

echo "---- BACKUP SESSION END ----" >> $LOG_FILE
echo >> $LOG_FILE