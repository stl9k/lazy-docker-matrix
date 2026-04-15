#!/bin/bash
# Generate initial Synapse homeserver configuration and apply custom settings

# Load environment variables
source .env

echo ">>> Generating Synapse configuration for domain: ${DOMAIN}..."

# Run the official Synapse image to generate a clean configuration
docker run -it --rm \
  -v ./matrix/data:/data \
  -e SYNAPSE_SERVER_NAME=${DOMAIN} \
  -e SYNAPSE_REPORT_STATS=no \
  matrixdotorg/synapse:latest generate

# Fix permissions for the mounted volume (Synapse user inside container is UID 991)
sudo chown -R 991:991 ./matrix/data

echo ">>> Configuration file created at matrix/data/homeserver.yaml"

# Apply custom configuration automatically
./scripts/configure_synapse.sh

echo ">>> Full setup complete!"