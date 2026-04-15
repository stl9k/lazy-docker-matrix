-include .env
export

.PHONY: help install-docker setup generate-config configure-synapse get-certs create-admin up logs clean generate-nginx-config generate-element-config

help:
	@echo "Available commands:"
	@echo "  make install-docker       - Install Docker on a clean VPS"
	@echo "  make setup                - Prepare .env file and required directories"
	@echo "  make generate-nginx-config - Generate nginx.conf from template"
	@echo "  make generate-element-config - Generate element config.json from template"
	@echo "  make generate-config      - Generate and configure Synapse homeserver.yaml"
	@echo "  make configure-synapse    - Apply custom configuration to existing homeserver.yaml"
	@echo "  make get-certs            - Obtain SSL certificates from Let's Encrypt"
	@echo "  make create-admin         - Create an administrator user in Synapse"
	@echo "  make up                   - Start all services (Matrix, Element, Nginx, Certbot)"
	@echo "  make logs                 - Show logs for all services"
	@echo "  make clean                - Stop and remove all containers and data (Dangerous!)"

install-docker:
	@echo "Installing Docker..."
	curl -fsSL https://get.docker.com | sudo sh

	generate-nginx-config:
	@echo "Generating nginx configuration from template..."
	@chmod +x scripts/generate_nginx_config.sh
	./scripts/generate_nginx_config.sh

generate-element-config:
	@echo "Generating Element configuration from template..."
	@chmod +x scripts/generate_element_config.sh
	./scripts/generate_element_config.sh

generate-nginx-config:
	@echo "Generating nginx configuration from template..."
	@chmod +x scripts/generate_nginx_config.sh
	./scripts/generate_nginx_config.sh

setup:
	@echo "Setting up environment..."
	cp -n .env.example .env
	@echo "Please edit the .env file and set your domain, email, and other parameters."
	mkdir -p certbot/{conf,www} element matrix/data nginx scripts
	chmod +x scripts/*.sh
	$(MAKE) generate-nginx-config
	$(MAKE) generate-element-config

generate-config:
	@echo "Generating and configuring Synapse..."
	@chmod +x scripts/generate_synapse_config.sh scripts/configure_synapse.sh
	./scripts/generate_synapse_config.sh

configure-synapse:
	@echo "Applying custom configuration to Synapse..."
	@chmod +x scripts/configure_synapse.sh
	./scripts/configure_synapse.sh

get-certs:
	@echo "Obtaining SSL certificates..."
	@chmod +x scripts/obtain_certificates.sh
	./scripts/obtain_certificates.sh

create-admin:
	@echo "Creating administrator user..."
	@chmod +x scripts/create_admin_user.sh
	./scripts/create_admin_user.sh

up:
	@echo "Starting main stack..."
	docker compose up -d

logs:
	docker compose logs -f

clean:
	@echo "Stopping all services and removing data..."
	docker compose down -v
	rm -rf matrix/data/homeserver.db certbot/conf
	@echo "Project cleaned."