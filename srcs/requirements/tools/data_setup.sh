#!/bin/bash

# setup the folder for persistent data
data_folder="$HOME/data"

if [ ! -e "$data_folder" ]; then
    mkdir -p "$data_folder"
    echo "$data_folder created!"
fi
