# DockerAutoBackup

This is the auto backup script for docker volumes.
Support OS: Ubuntu Linux.
It is preferred to run the script with root user.
It will pull busybox at the first time if you haven't deployed it yet on docker.
Run ```./setup.sh``` to start configuration.
Connect to storing machine via SFTP first to make sure that you have got host key.