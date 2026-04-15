#!/bin/bash
# Generate nginx.conf from template using .env variables

source .env

# Validate DOMAIN is set
if [ -z "$DOMAIN" ] || [ "$DOMAIN" = "chat.example.com" ]; then
    echo "ERROR: DOMAIN is not set correctly in .env file!"
    echo "Please edit .env and set your actual domain."
    exit 1
fi

TEMPLATE_FILE="./nginx/nginx.conf.template"
OUTPUT_FILE="./nginx/nginx.conf"

echo ">>> Generating nginx configuration for domain: ${DOMAIN}..."

# Replace {{DOMAIN}} placeholder with actual domain using sed
sed "s|{{DOMAIN}}|${DOMAIN}|g" "${TEMPLATE_FILE}" > "${OUTPUT_FILE}"

echo ">>> nginx.conf generated successfully!"