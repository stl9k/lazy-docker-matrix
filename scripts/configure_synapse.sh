#!/bin/bash
# Apply custom configuration to generated homeserver.yaml

source .env

CONFIG_FILE="./matrix/data/homeserver.yaml"

echo ">>> Applying custom configuration to ${CONFIG_FILE}..."

# Function to update or add a YAML key with a value
set_yaml_value() {
    local key="$1"
    local value="$2"
    
    if grep -q "^${key}:" "${CONFIG_FILE}"; then
        # Key exists, replace it
        sed -i "s|^${key}:.*|${key}: ${value}|g" "${CONFIG_FILE}"
    else
        # Key doesn't exist, append it
        echo "${key}: ${value}" >> "${CONFIG_FILE}"
    fi
}

# Function to add a block if it doesn't exist
ensure_listeners_block() {
    if ! grep -q "^listeners:" "${CONFIG_FILE}"; then
        cat >> "${CONFIG_FILE}" << 'EOF'
listeners:
  - port: 8008
    resources:
    - compress: false
      names:
      - client
      - federation
    tls: false
    type: http
    x_forwarded: true
EOF
    fi
}

echo ">>> Setting core configuration values..."

# Set essential values
set_yaml_value "public_baseurl" "\"https://${DOMAIN}\""
set_yaml_value "enable_registration" "true"
set_yaml_value "enable_registration_without_verification" "true"
set_yaml_value "suppress_key_server_warning" "true"

# Ensure listeners block with x_forwarded
ensure_listeners_block

# Update existing listeners to have x_forwarded: true
sed -i '/listeners:/,/^[a-z]/{s/x_forwarded: false/x_forwarded: true/g}' "${CONFIG_FILE}"
sed -i '/listeners:/,/^[a-z]/{/x_forwarded:/!s/type: http/type: http\n    x_forwarded: true/}' "${CONFIG_FILE}"

echo ">>> Configuration applied successfully!"
echo ">>> You can review the changes in ${CONFIG_FILE}"