# Autobackup for macOS

## Overview
This project provides a set of scripts designed to perform automated backups and cleanup tasks on macOS using the `rsync` utility. The primary scripts included are `rsync-backup.sh` and `rsync-cleanup.sh`, each serving distinct purposes to ensure your data is efficiently backed up and unnecessary files are removed as required.

## Script Descriptions

### rsync-backup.sh
The `rsync-backup.sh` script is responsible for creating backups of specified directories. It utilizes the powerful `rsync` command to perform incremental backups, ensuring that only new or modified files are copied, thus optimizing the backup process. This script offers the following features:
- **Source and Destination Configuration:** Users can specify which directories to back up and where to store the backup.
- **Exclusion Rules:** Users can define certain patterns or files to exclude from the backup process, making it customizable to fit specific needs.
- **Logging:** The script maintains logs of the backup operations, which can be useful for monitoring and troubleshooting.

### rsync-cleanup.sh
The `rsync-cleanup.sh` script is designed to remove backup files that are no longer needed. This script helps in maintaining storage efficiency by deleting old backups according to user-defined retention policies. Key features include:
- **Retention Policy:** Users can set how long backups should be kept before being eligible for deletion.
- **Safe Deletion:** The script ensures that important files are not deleted inadvertently, providing a safeguard during operations.
- **Logging:** Similar to the backup script, it logs the cleanup actions taken for transparency and record-keeping.

## Usage
To utilize these scripts, ensure that you have `rsync` installed on your macOS system. Simply execute the desired script from the terminal:

```bash
./rsync-backup.sh
./rsync-cleanup.sh
```

## Conclusion
These scripts work together to provide a simple but effective solution for managing backups on macOS. By leveraging `rsync`, they ensure data integrity and minimize storage use while keeping the user informed through logging.