#!/usr/bin/env bash

# Prompt for the domain name
read -p "Enter Domain: " domain

# Set OpenSSL configuration file
export OPENSSL_CONF="/etc/ssl/openssl.cnf"

# Create the domain directory if it doesn't exist
if [[ ! -d "ssl/cert" ]]; then
  mkdir -p "ssl/cert" || {
    echo "Error: failed to create directory 'ssl/cert'."
    exit 1
  }
fi

# Generate the self‐signed certificate
/usr/bin/openssl req \
  -config ./ssl/cert.conf \
  -new -sha256 \
  -newkey rsa:2048 \
  -nodes \
  -keyout "ssl/cert/server.key" \
  -x509 \
  -days 365 \
  -out "ssl/cert/server.crt"

# Display completion message
echo
echo "-----"
echo "The certificate was provided."
echo

# Pause (wait for any key)
read -n1 -r -p "Press any key to continue . . ." key
echo
