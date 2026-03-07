DESTINATION="/Volumes/Backup"
SOURCE_LIST="/Users/bentoon/BackupScript/source_folders.txt"
LOG_FILE="deletions.log"

#Verify source list file exists
if [ ! -f "$SOURCE_LIST" ]; then
    echo "Error: $SOURCE_LIST does not exist." >&2
    exit 1
fi

#Verify destination exists
if [ ! -d "$DESTINATION" ]; then
    echo "ERROR: Destination ($DESTINATION) does not exist."
    echo "Connect the device and try again."
    exit 1
fi

#Verify log file exists
if [ ! -d "$LOG_FILE" ]; then
    touch deletions.log
    echo "Error: No log file\n -> Created new log file"
fi

echo "This will remove any files deleted from the source folder from the backup USB drive."
echo "Files to be deleted:"
while IFS= read -r source_dir || [ -n "$source_dir" ]
do
	rsync --dry-run --delete -av --itemize-changes "$source_dir" "$DESTINATION" | grep '^*deleting'
done < "$SOURCE_LIST"

read -p "Do you want to continue with the deletion sync operation? (y/n): " user_response

if [[ $user_response == 'y' || $user_response == "Y" ]];
then
	echo "---- CLEANUP SESSION START ----" >> deletion-log.log
	while IFS= read -r source_dir || [ -n "$source_dir" ]
	do
		echo "Proceeding."
		echo "--Delete started: $(date) in folder $source_dir" >> deletion-log.log
		rsync --dry-run --delete -a --itemize-changes "$source_dir" "$DESTINATION" | grep '^*deleting' >> deletion-log.log
		 rsync -a --delete --stats "$source_dir" "$DESTINATION/" | awk '
    /Number of files transferred/ {print "Files transferred: " $5}
    /Total transferred file size/ {print "Total size (bytes): "$5}
    ' >> transfer-log.log
		echo "Logged. Deleting..."
		rsync --delete -av "$source_dir" "$DESTINATION"
		
		rsync -a --stats "$source_dir" "$DESTINATION/" | awk '
    /Number of files transferred/ {print "Files transferred: " $5}
    /Total transferred file size/ {print "Total size (bytes): "$5}
    ' >> transfer-log.log
		echo "--Delete ended: $(date) in $source_dir\n" >> deletion-log.log
		
		echo "Cleanup complete."
	done < "$SOURCE_LIST"
else
	echo "Operation cancelled."
fi
echo "---- CLEANUP SESSION END ---- \n" >> deletion-log.log