#!/bin/bash
# Generate nginx.conf from template using .env variables

source .env

TEMPLATE_FILE="./nginx/nginx.conf.template"
OUTPUT_FILE="./nginx/nginx.conf"

echo ">>> Generating nginx configuration for domain: ${DOMAIN}..."

# Replace ${DOMAIN} with actual domain from .env
envsubst '${DOMAIN}' < "${TEMPLATE_FILE}" > "${OUTPUT_FILE}"

echo ">>> nginx.conf generated successfully!"