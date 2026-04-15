#!/bin/bash
# Create an administrator user in Synapse

source .env

echo ">>> Creating administrator user: ${ADMIN_USERNAME}..."

# Execute the registration command inside the running Synapse container
docker compose exec -T synapse register_new_matrix_user \
  -c /data/homeserver.yaml \
  -u ${ADMIN_USERNAME} \
  -p ${ADMIN_PASSWORD} \
  -a \
  http://localhost:8008

echo ">>> Administrator user '${ADMIN_USERNAME}' created successfully."