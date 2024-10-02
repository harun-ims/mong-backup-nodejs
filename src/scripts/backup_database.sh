#!/bin/bash

# MongoDB connection details from environment variables with fallback
MONGO_URI="${MONGO_URI:-mongodb://localhost:27017}" 
DB_NAME="${DB_NAME:-db}"       

# Determine the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup directory and file
BACKUP_DIR="mongo_backup"
BACKUP_FILE="$SCRIPT_DIR/mongo_backup.tar.gz"

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Step 1: Dump the entire database
echo "Backing up $DB_NAME..."
mongodump --uri="$MONGO_URI" --db="$DB_NAME" --out="$BACKUP_DIR"
if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
else
    echo "Backup failed."
    exit 1
fi

# Step 2: Compress the backup directory into a tar.gz file
echo "Compressing backup into $BACKUP_FILE..."
tar -czvf "$BACKUP_FILE" -C "$BACKUP_DIR" "$DB_NAME"
if [ $? -eq 0 ]; then
    echo "Compression completed successfully."
else
    echo "Compression failed."
    exit 1
fi

# Cleanup
rm -rf "$BACKUP_DIR"

echo "Backup stored in $BACKUP_FILE."
