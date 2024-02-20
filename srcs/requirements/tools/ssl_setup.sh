#!/bin/bash

output_folder="./srcs/requirements/nginx/ssl"
certificate_file="$output_folder/inception.crt"
private_key="$output_folder/inception.key"

# create folder if not exists
if [ ! -e "$output_folder" ]; then
    mkdir -p "$output_folder"
fi

# generate a self-signed certificate
# check if the certificate file already exists
if [ ! -e "$certificate_file" ]; then
    # generate private key
    openssl genpkey -algorithm RSA -out "$private_key"

    # generate a self-signed certificate using the private key
    openssl req -new -x509 -key "$private_key" -out "$certificate_file" -days 365 -subj "/C=MY/ST=Kuala Lumpur/L=Kuala Lumpur/O=42KL/OU=42KL/CN=wricky-t.42.fr"

    echo "Self-signed certificate generated successfully."
else
    echo "Certificate file already exists: $certificate_file"
fi
