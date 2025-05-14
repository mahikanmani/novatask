#! /bin/bash

# variable Configuration

APP_DIR="/var/www/app"
BACKUP_DIR="/backup"
TIMESTAMP=$(date +"%Y-%m-%d")
LOG_FILE="$BACKUP_DIR/backup.log"
RETENTION_DAYS=7
BACKUP_FILENAME="app-backup-$TIMESTAMP.tar.gz"
DEPENDENCIES= "tar" "gzip" "cron"



#check depndencies

for cmd in "${DEPENDENCIES[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "[ERROR] Required command '$cmd' is not installed. exiting"
    fi 
done

#ensure backup dir exists
mkdir -p "$BACKUP_DIR"

# backup
echo "[INFO] starting backup of $APP_DIR at $(date)" | tee -a "$LOG_FILE"
if tar -czf "$BACKUP_DIR/$BACKUP_FILENAME" -C "$(dirname "$APP_DIR")" "$(basename "$APP_DIR")"; then
    echo "[SUCCESS] backup is Completed: $BACKUP_DIR/$BACKUP_FILENAME" | tee -a "$LOG_FILE"
else
    echo "[ERROR] backup failed during tar opearation." | tee -a "$LOG_FILE"
    exit 1
fi


# clearing old files

echo "[INFO] Removing backup folder older than $RETENTION_DAYS days..." | tee -a "$LOG_FILE"
find "$BACKUP_DIR" -type f -name "app-backup-*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;
echo "[INFO] cleanup completed." | tee -a "$LOG_FILE"

exit 0

