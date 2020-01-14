# DockerAutoBackup

This is the auto backup script for docker volumes.
Before backing up, please make sure you have connected to the machine which stores the backup files with SFTP before.
It is preferred to run the script with root user.
It will pull busybox at the first time if you haven't deployed it yet on docker.