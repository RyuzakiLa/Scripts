#!/bin/bash

# Set the proxy information
PROXY_HOST="127.0.0.1"
PROXY_PORT="8080"

# Set the list of URLs file
URLS_FILE="wuff.txt"

# Check if the file exists
if [[ ! -f "$URLS_FILE" ]]; then
    echo "URL file '$URLS_FILE' not found!"
    exit 1
fi

# Iterate over each URL and send the request using curl
while IFS= read -r url; do
    curl -k -x "$PROXY_HOST:$PROXY_PORT" "$url"
done < "$URLS_FILE"
