# Autobackup scripts for macOS
This project provides a set of scripts designed to perform automated backups and cleanup tasks on macOS using the `rsync` utility. The primary scripts included are `rsync-backup.sh` and `rsync-cleanup.sh`. By default, only tracked changes are cloned, hugely reducing transfer time which is especially useful for slower USB thumb drive use. Cleanup script allows folders to be synced by remove files that are no longer in the source folder (be careful!).

## Setup
macOS includes `rsync` by default, but ensure that you have it installed using `rsync --version`. 
If it is not found, use [brew.sh](brew) or [https://github.com/RsyncProject/rsync/releases](rsync releases) to install the package.

Simply execute the desired script from the terminal:

```bash
./rsync-backup.sh
# Optionally run cleanup script to remove files missing from source directory
./rsync-cleanup.sh
```

These scripts can be run in conjunction with `cron` or `automator`/`Apple Script` to start either on a schedule or as drives are connected to the system.
## Script Descriptions

### rsync-backup.sh
The `rsync-backup.sh` script is responsible for creating backups of specified directories. It utilises the powerful `rsync` command to perform incremental backups, ensuring that only new or modified files are copied, thus optimizing the backup process. This script offers the following features:
- **Source and Destination Configuration:** Users can specify which directories to back up and where to store the backup.
- **Exclusion Rules:** Users can define certain patterns or files to exclude from the backup process, making it customizable to fit specific needs.
- **Logging:** The script maintains logs of the backup operations, which can be useful for monitoring and troubleshooting.

### rsync-cleanup.sh
The `rsync-cleanup.sh` script is designed to remove backup files that are no longer needed. This script helps in maintaining storage efficiency by deleting old backups. Key features include:
- **Safe Deletion:** The script ensures that important files are not deleted inadvertently, providing a safeguard during operations.
- **Logging:** Similar to the backup script, it logs the cleanup actions taken for transparency and record-keeping.
⚠️ Be careful with this script! The goal is to make sure source and destination are identical copies, not maintain versioned history. Running this command will resync the destination location by removing files, keep that in mind :) 

Contributions are of course welcomed, feel free to submit any pull requests and I will occasionally review them :)
- Ben
