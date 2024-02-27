#!/bin/bash

# setup the folder for persistent data
data_folder="$HOME/data"
ssl_folder="$data_folder/ssl"
html_folder="$data_folder/html"


if [ ! -e "$data_folder" ]; then
    mkdir -p "$data_folder"
    mkdir -p "$ssl_folder"
    mkdir -p "$html_folder"
    echo "$data_folder created!"
fi
