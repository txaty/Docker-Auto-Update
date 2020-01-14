#!/bin/bash

echo -e "Installing necessary dependencies..."
apt update -y
apt install -y python3
apt install -y python3-pip
pip3 install pysftp
chmod a+x backup.sh
chmod a+x remove_old_file.py

cd ..
echo -e "\n Here, $(pwd) will be the directory where you store your backup files on the local machine. \n"
replace_string=BACKUP_PATH=\"$(pwd)\/\"
cd Docker-Auto-Update
sed -i "3s#.*#$replace_string#" backup.sh

echo -e "Please specify the containers to backup. currently the containers are: "
sed -n '4p' backup.sh | cut -d "\"" -f2
echo -e "Input ENTER only to unchange, or divide each name by blank space: \n> \c"
read CONTAINER_NAMES
if [ "$CONTAINER_NAMES" == "" ];
    then
        echo -e "Unchanged."
    else
        replace_string=CONTAINER_NAMES=\"$CONTAINER_NAMES\"
        sed -i "4s#.*#$replace_string#" backup.sh
        echo -e "Changed to: $CONTAINER_NAMES."
fi
echo 

echo -e "Please specify the user for sftp connection. Currently the user is: "
sed -n '3p' transfer.py | cut -d "'" -f2
echo -e "Input ENTER only to unchange, or type a new name: \n> \c"
read THE_USER_NAME
if [ "$THE_USER_NAME" == "" ];
    then
        echo -e "Unchanged."
    else
        replace_string="USER = '$THE_USER_NAME'"
        sed -i "3s#.*#$replace_string#" transfer.py
        echo -e "Changed to: $THE_USER_NAME."
fi

echo -e "Please specify the host for sftp connection. Currently the host is: "
sed -n '4p' transfer.py | cut -d "'" -f2
echo -e "Input ENTER only to unchange, or type a new name: \n> \c"
read THE_HOST_NAME
if [ "$THE_HOST_NAME" == "" ];
    then
        echo -e "Unchanged."
    else
        replace_string="HOST = '$THE_HOST_NAME'"
        sed -i "4s#.*#$replace_string#" transfer.py
        echo -e "Changed to: $THE_HOST_NAME."
fi

echo -e "Please input password for connection, note that the program will only store password in plain text now (press ENTER to unchange): \n> \c"
read -s PASSWORD
if [ "$PASSWORD" == "" ];
    then
        echo -e "Unchanged."
    else
        replace_string="PASSWORD = '$PASSWORD'"
        sed -i "5s#.*#$replace_string#" transfer.py
        echo -e "Password set."
fi

echo -e "Please specify the path for host to store backups. Currently the path is: "
sed -n '6p' transfer.py | cut -d " " -f3
echo -e "Input ENTER only to unchange, or type a new name: \n> \c"
read BACKUP_PATH
if [ "$BACKUP_PATH" == "" ];
    then
        echo -e "Unchanged."
    else
        replace_string="HOST = '$BACKUP_PATH'"
        sed -i "6s#.*#$replace_string#" transfer.py
        echo -e "Changed to: $BACKUP_PATH."
fi

echo -e "Making changes on the other machine..."
python3 transfer.py i
