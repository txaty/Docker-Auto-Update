#!/bin/bash

CONTAINER_NAMES="mongo gogs"
BACKUP_PATH="/root/DockerVolumeBackups"
TODAY="$(date "+%Y-%m-%d")"
LOG_FILE="log/$TODAY.log"
MAX_BUFFER_SIZE="3"

cd "$BACKUP_PATH"

create_backup_file()
{
    mkdir -p "log" && touch $LOG_FILE
    for item in $CONTAINER_NAMES
    do
        echo "-----Creating backup file for container: $item-----" >> "$LOG_FILE"
        sudo docker run --rm --volumes-from $item -v $BACKUP_PATH/backups:/backup busybox tar cvf /backup/$TODAY-$item.tar data >> "$LOG_FILE"
    done
}

remove_old_file()
{   
    cd "DockerAutoBackup"
    /usr/bin/python3  remove_old_file.py  $BACKUP_PATH $MAX_BUFFER_SIZE $CONTAINER_NAMES
    cd ..
}
# create_backup_file
remove_old_file
# create_backup_file
# create a new data container
# sudo docker create -v /data --name DATA2 busybox true
# untar the backup files into the new container᾿s data volume
# sudo docker run --rm --volumes-from DATA2 -v $(pwd):/backup busybox tar xvf /backup/backup.tar
# compare to the original container
# sudo docker run --rm --volumes-from DATA -v `pwd`:/backup busybox ls /data
