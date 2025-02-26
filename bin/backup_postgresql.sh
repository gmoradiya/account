
#!/bin/bash

# Set variables
DB_NAME="follow_up_dev"
DB_USER="postgres"
# SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "---------------------$SCRIPT_DIR"
BACKUP_DIR="/home/rails/shiv_account/storage/backups"

BACKUP_FILE="$BACKUP_DIR/$(date +%Y%m%d_%H%M%S)_$DB_NAME.dump"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run pg_dump
PGPASSWORD="postgres" pg_dump -U $DB_USER -d $DB_NAME -F c -f $BACKUP_FILE

# Optional: Delete backups older than 2 days
find $BACKUP_DIR -type f -name "*.dump" -mtime +2 -exec rm {} \;

echo "Backup completed: $BACKUP_FILE"

# restore data
# pg_restore -U postgres -d "follow_up_dev" -c backup_file_name.dump
