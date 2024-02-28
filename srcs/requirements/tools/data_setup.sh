#!/bin/bash

# setup the folder for persistent data
data_folder="$HOME/data"
ssl_folder="$data_folder/ssl"
html_folder="$data_folder/html"
db_folder="$data_folder/db"


if [ ! -e "$data_folder" ]; then
    mkdir -p "$ssl_folder"
    mkdir -p "$html_folder"
    mkdir -p "$db_folder"
    echo "$data_folder created!"
fi
