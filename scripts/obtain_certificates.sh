#!/bin/bash
# Obtain SSL certificates from Let's Encrypt using Certbot in standalone mode

source .env

echo ">>> Stopping any services using port 80..."
docker compose stop nginx 2>/dev/null || true

echo ">>> Requesting certificate for domain: ${DOMAIN}..."
docker run -it --rm \
  -p 80:80 \
  -v ./certbot/conf:/etc/letsencrypt \
  -v ./certbot/www:/var/www/certbot \
  certbot/certbot certonly \
  --standalone \
  --email ${EMAIL} \
  --agree-tos \
  --no-eff-email \
  -d ${DOMAIN}

echo ">>> Certificates obtained and saved to ./certbot/conf/"
echo ">>> You can now start the main stack with 'make up'."