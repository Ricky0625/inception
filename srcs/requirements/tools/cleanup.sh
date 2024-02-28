#!/bin/bash

data_folder="$HOME/data"

if [ -e "$data_folder/ssl" ]; then
    rm -rf "$data_folder/ssl/*"
fi

if [ -e "$data_folder/html" ]; then
    sudo rm -rf "$data_folder/html/*"
fi

if [ -e "$data_folder/db" ]; then
    rm -rf "$data_folder/db/*"
fi
