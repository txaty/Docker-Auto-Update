#!/bin/bash

CONTAINER_NAMES="gogs"
BACKUP_PATH="/root/DockerVolumeBackups"
TODAY="$(date "+%Y-%m-%d-%H:%M:%S")"
LOG_FILE="log/$TODAY.log"
MAX_BUFFER_SIZE="5"

mkdir -p "$BACKUP_PATH"
cd "$BACKUP_PATH"
mkdir -p "log" && touch $LOG_FILE

create_backup_file()
{
    for item in $CONTAINER_NAMES
    do
        echo "-----Creating backup file for container: $item-----" >> "$LOG_FILE"
        sudo docker run --rm --volumes-from $item -v $BACKUP_PATH/backups:/backup busybox tar cvf /backup/$TODAY-$item.tar data >> "$LOG_FILE"
        echo "-----Finished-----" >> "$LOG_FILE"
    done
}

remove_old_file()
{   
    echo "-----Removing old backup files-----" >> "$LOG_FILE"
    cd "Docker-Auto-Update"
    /usr/bin/python3  remove_old_file.py  $BACKUP_PATH $MAX_BUFFER_SIZE $CONTAINER_NAMES >> "../$LOG_FILE" 2>&1
    cd ..
    echo "-----Removing finished-----" >> "$LOG_FILE"
}
create_backup_file
remove_old_file
