#!/bin/bash
# Generate element config.json from template using .env variables

source .env

# Validate DOMAIN is set
if [ -z "$DOMAIN" ] || [ "$DOMAIN" = "chat.example.com" ]; then
    echo "ERROR: DOMAIN is not set correctly in .env file!"
    echo "Please edit .env and set your actual domain."
    exit 1
fi

# Set defaults if not defined in .env
BRAND="${BRAND:-Element}"
DEFAULT_COUNTRY_CODE="${DEFAULT_COUNTRY_CODE:-US}"
DEFAULT_THEME="${DEFAULT_THEME:-dark}"

TEMPLATE_FILE="./element/config.json.template"
OUTPUT_FILE="./element/config.json"

echo ">>> Generating Element configuration for domain: ${DOMAIN}..."

# Replace placeholders with sed
sed -e "s|{{DOMAIN}}|${DOMAIN}|g" \
    -e "s|{{BRAND}}|${BRAND}|g" \
    -e "s|{{DEFAULT_COUNTRY_CODE}}|${DEFAULT_COUNTRY_CODE}|g" \
    -e "s|{{DEFAULT_THEME}}|${DEFAULT_THEME}|g" \
    "${TEMPLATE_FILE}" > "${OUTPUT_FILE}"

echo ">>> Element config.json generated successfully!"