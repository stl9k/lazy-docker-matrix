# lazy-docker-matrix

Setup for **Matrix Synapse** + **Element Web** with automated **Nginx** reverse proxy and **Let's Encrypt** SSL certificates.

## Features

- 🐳 **Fully Dockerized** — all services run in isolated containers.
- 🔒 **Automatic HTTPS** — Let's Encrypt certificates with auto‑renewal via Certbot.
- ⚙️ **Configuration templates** — everything generated from a single `.env` file.
- 🛡️ **Secure by default** — only Nginx exposed; internal services communicate privately.
- 🚀 **One‑command setup** — from clean VPS to working chat in minutes.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/stl9k/lazy-docker-matrix.git
cd lazy-docker-matrix/

# Install Docker (if not already installed)
make install-docker

# Create and edit your .env file
make setup
nano .env

# Generate Matrix configuration and SSL certificates
make generate-config
make get-certs

# Start all services
make up

# Create your admin user
make create-admin
