#!/bin/bash

ssl_folder="./srcs/requirements/nginx/ssl"
data_folder="$HOME/data"

if [ -e "$ssl_folder" ]; then
    rm -rf "$ssl_folder"
    echo "Deleted $ssl_folder"
fi

if [ -e "$data_folder" ]; then
    rm -rf "$data_folder"
    echo "Deleted $data_folder"
fi
