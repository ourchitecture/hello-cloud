# docker | podman
dev_tool:=docker
cloud:=

app_port=3000
host_port:=3000

base_image_tag:=docker.io/library/node:16.13.1-alpine3.12

container_name:=our-hello-nodejs-expressjs-webapi
image_tag:=our-hello-nodejs-expressjs-webapi:latest

docker_push_registry:=ghcr.io
docker_push_organization_or_user:=ourchitecture
docker_push_repository:=hello-cloud
docker_push_image_tag:=$(docker_push_registry)/$(docker_push_organization_or_user)/$(docker_push_repository)/$(image_tag)

heroku_app_name:=our-hellonodejsexpressjswebapi

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud" "heroku"))
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make $@; \
	cd $$prev_dir;
else ifeq '$(dev_tool)' 'yarn'
	@set -eu \
	&& yarn
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","node" "npm"))
	@set -eu \
	&& npm install
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG="$(image_tag)" \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
	$(dev_tool) \
		--file ./docker/docker-compose.yml \
		build \
	&& echo 'Successfully built: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./docker/Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
endif

.PHONY: check-versions
check-versions:
	@./check-versions.sh

.PHONY: start
start: install
ifeq '$(dev_tool)' 'yarn'
	@set -eu \
	&& yarn start
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","node" "npm"))
	@set -eu \
	&& npm start
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG="$(image_tag)" \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
	$(dev_tool) \
		--file ./docker/docker-compose.yml \
		up \
		--detach
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) run \
		--name $(container_name) \
		--detach \
		--publish $(host_port):$(app_port) \
		$(image_tag)
endif
	@echo 'Successfully started: http://localhost:$(host_port)'

.PHONY: stop
stop:
# nothing to do for "yarn" or "node" / "npm"
ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
	$(dev_tool) \
		--file ./docker/docker-compose.yml \
		down \
	&& echo 'Successfully removed container: $(container_name)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","podman" "docker"))
	@set -eu \
	&& $(dev_tool) rm -f $(container_name) \
	&& echo 'Successfully removed container: $(container_name)'
endif

.PHONY: logs
logs:
# TODO: docker container logs
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud" "heroku"))
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make $@; \
	cd $$prev_dir;
endif

.PHONY: clean
clean:
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud" "heroku"))
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make $@; \
	cd $$prev_dir;
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","yarn" "node" "npm"))
# removing "package-lock.json" for local dev "node" / "npm" use,
# but not "yarn.lock" used by the project
	@set -eu \
	&& rm -rf .yarn/cache/ .yarn/install-state.gz node_modules/ package-lock.json
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
	$(dev_tool) \
		--file ./docker/docker-compose.yml \
		rm \
		--stop \
		--force \
	&& echo 'Successfully removed image: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) rmi -f $(image_tag) \
	&& echo 'Successfully removed image: $(image_tag)'
endif

.PHONY: deploy
deploy: install
ifneq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	$(error The "$@" command target only supports "dev_tool=docker" or "dev_tool=podman")
endif
ifeq ("${DOCKER_USERNAME}", "")
	$(error Missing environment variable "DOCKER_USERNAME")
endif
ifeq ("${DOCKER_PASSWORD_FILE_PATH}", "")
	$(error Missing environment variable "DOCKER_PASSWORD_FILE_PATH")
endif
	@set -eu \
	&& $(dev_tool) tag "$(image_tag)" "$(docker_push_image_tag)" \
	&& cat "${DOCKER_PASSWORD_FILE_PATH}" \
		| $(dev_tool) login "$(docker_push_registry)" \
			--username "${DOCKER_USERNAME}" \
			--password-stdin \
	&& $(dev_tool) push "$(docker_push_image_tag)"

# convenience aliases
build: install
test: check
up: start
run: start
serve: start
down: stop
uninstall: clean

.PHONY: sync
sync:
	@git-town sync
