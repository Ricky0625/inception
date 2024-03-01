#!/bin/bash

# check if the ftp user exists
# &>/dev/null to redirect stdout and stderr to /dev/null, slicing any output or error messsages
if id "$FTP_USER" &>/dev/null; then
    exec "$@"
fi

# create ftp user here

# create user and create its home directory
useradd -m "$FTP_USER"
# set password
echo "$FTP_USER:$FTP_PASS" | chpasswd
# ensure that ftp user has access to files and directories owned by
# the www-data group, which is necessary for us to access the wordpress volume
usermod -aG www-data "$FTP_USER"

exec "$@"
