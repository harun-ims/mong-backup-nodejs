#!/bin/bash

# MongoDB connection details from environment variables with fallback
MONGO_URI="${MONGO_URI:-mongodb://localhost:27017}" 
DB_NAME="${DB_NAME:-db}"                    

# Determine the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup file and directory
BACKUP_FILE="$SCRIPT_DIR/mongo_backup.tar.gz"
BACKUP_DIR="mongo_backup"

# Step 1: Drop the existing database
echo "Dropping existing database $DB_NAME..."
mongosh "$DB_NAME" --eval "db.dropDatabase()"
if [ $? -eq 0 ]; then
    echo "Database $DB_NAME dropped successfully."
else
    echo "Failed to drop database $DB_NAME."
    exit 1
fi

# Step 2: Create the backup directory if it does not exist
echo "Creating backup directory $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

# Step 3: Extract the tar.gz backup file
echo "Extracting backup $BACKUP_FILE..."
tar -xzvf "$BACKUP_FILE" -C "$BACKUP_DIR"
if [ $? -eq 0 ]; then
    echo "Extraction completed successfully."
else
    echo "Failed to extract backup."
    exit 1
fi

# Step 4: Restore the backup into the database
echo "Restoring database $DB_NAME..."
mongorestore --uri="$MONGO_URI" --db="$DB_NAME" "$BACKUP_DIR/$DB_NAME"
if [ $? -eq 0 ]; then
    echo "Restore completed successfully."
else
    echo "Restore failed."
    exit 1
fi

# Step 5: Cleanup the backup directory
rm -rf "$BACKUP_DIR"

# Step 6: Remove the backup file after successful restore
rm -f "$BACKUP_FILE"

echo "Database restore completed."
