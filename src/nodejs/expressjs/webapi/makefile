container_tool:=podman

app_port=3000
host_port:=3000

base_image_tag:=docker.io/library/node:17.0.1-alpine3.12

container_name:=our-hello-nodejs-expressjs-webapi
image_tag:=our-hello-nodejs-expressjs-webapi:latest

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
ifneq '$(container_tool)' 'docker-compose'
	@set -eu \
	&& $(container_tool) build \
		-t $(image_tag) \
		-f ./Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
endif

.PHONY: up
up: install
ifeq '$(container_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	docker-compose up -d
else
	@set -eu \
	&& $(container_tool) run \
		--name $(container_name) \
		-d \
		-v $(shell pwd):/app \
		-w /app \
		-p $(app_port):$(host_port) \
		$(image_tag) \
		npm start
endif
	@echo 'Successfully started: http://localhost:$(host_port)'

.PHONY: down
down:
ifeq '$(container_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	docker-compose down
else
	@set -eu \
	&& $(container_tool) rm -f $(container_name)
endif
	@echo 'Successfully removed container: $(container_name)'

.PHONY: clean
clean:
ifeq '$(container_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	docker-compose rm -s -f
else
	@set -eu \
	&& $(container_tool) rmi -f $(image_tag)
endif
	@echo 'Successfully removed image: $(image_tag)'

# convenient alias
.PHONY: uninstall
uninstall: clean

.PHONY: start
start: up

# convenient alias
.PHONY: run
run: up

# convenient alias
.PHONY: serve
serve: up

.PHONY: sync
sync:
	@git-town sync
