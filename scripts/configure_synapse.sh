#!/bin/bash
# Apply custom configuration to generated homeserver.yaml using sed

source .env

CONFIG_FILE="./matrix/data/homeserver.yaml"

# Validate DOMAIN is set
if [ -z "$DOMAIN" ] || [ "$DOMAIN" = "chat.example.com" ]; then
    echo "ERROR: DOMAIN is not set correctly in .env file!"
    echo "Please edit .env and set your actual domain."
    exit 1
fi

echo ">>> Applying custom configuration to ${CONFIG_FILE}..."

# Function to update or add a YAML key with a value
set_yaml_value() {
    local key="$1"
    local value="$2"
    
    if grep -q "^${key}:" "${CONFIG_FILE}"; then
        # Key exists, replace it
        sed -i "s|^${key}:.*|${key}: ${value}|" "${CONFIG_FILE}"
    else
        # Key doesn't exist, append it
        echo "${key}: ${value}" >> "${CONFIG_FILE}"
    fi
}

echo ">>> Setting core configuration values..."

# Set essential values
set_yaml_value "public_baseurl" "\"https://${DOMAIN}\""
set_yaml_value "enable_registration" "true"
set_yaml_value "enable_registration_without_verification" "true"
set_yaml_value "suppress_key_server_warning" "true"

# Update existing listeners to have x_forwarded: true
sed -i '/listeners:/,/^[a-z]/{s/x_forwarded: false/x_forwarded: true/}' "${CONFIG_FILE}"
sed -i '/listeners:/,/^[a-z]/{/x_forwarded:/!s/type: http/type: http\n    x_forwarded: true/}' "${CONFIG_FILE}"

echo ">>> Configuration applied successfully!"