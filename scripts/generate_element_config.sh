#!/bin/bash
# Generate element config.json from template using .env variables

source .env

TEMPLATE_FILE="./element/config.json.template"
OUTPUT_FILE="./element/config.json"

# Set defaults if not defined in .env
export BRAND="${BRAND:-Element}"
export DEFAULT_COUNTRY_CODE="${DEFAULT_COUNTRY_CODE:-US}"
export DEFAULT_THEME="${DEFAULT_THEME:-dark}"

echo ">>> Generating Element configuration for domain: ${DOMAIN}..."

# Replace variables in template
envsubst '${DOMAIN} ${BRAND} ${DEFAULT_COUNTRY_CODE} ${DEFAULT_THEME}' < "${TEMPLATE_FILE}" > "${OUTPUT_FILE}"

echo ">>> Element config.json generated successfully!"