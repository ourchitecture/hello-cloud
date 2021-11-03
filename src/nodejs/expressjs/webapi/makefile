container_tool:=podman

app_port=3000
host_port:=3000

base_image_tag:=docker.io/library/node:17.0.1-alpine3.12

container_name:=our-hello-nodejs-expressjs-webapi
image_tag:=our-hello-nodejs-expressjs-webapi:latest

.DEFAULT_GOAL:=install

.PHONY: install
install:
	@set -eu \
	&& $(container_tool) pull \
		$(base_image_tag) \
	&& $(container_tool) tag \
		$(base_image_tag) \
		$(image_tag) \
	&& echo 'Successfully built: $(image_tag)'

.PHONY: up
up: install
	@set -eu \
	&& $(container_tool) run \
		--name $(container_name) \
		-d \
		-v $(shell pwd):/app \
		-w /app \
		-p $(app_port):$(host_port) \
		$(image_tag) \
		npm start \
	&& echo 'Successfully started: http://localhost:$(host_port)'

.PHONY: docker-compose-up
docker-compose-up:
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	docker-compose up -d \
	&& echo 'Successfully started: http://localhost:$(host_port)'

.PHONY: docker-compose-down
docker-compose-down:
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	docker-compose down

.PHONY: docker-compose-clean
docker-compose-clean:
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	docker-compose rm -s -f

.PHONY: down
down:
	@set -eu \
	&& $(container_tool) rm -f $(container_name) \
	&& echo 'Successfully removed container: $(container_name)'

.PHONY: clean
clean:
	@set -eu \
	&& $(container_tool) rmi -f $(image_tag) \
	&& echo 'Successfully removed image: $(image_tag)'

# convenient alias
.PHONY: uninstall
uninstall: clean

.PHONY: start
start:
	@yarn start

# convenient alias
.PHONY: run
run: start

# convenient alias
.PHONY: serve
serve: start
