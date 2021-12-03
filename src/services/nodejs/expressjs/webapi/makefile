dev_tool:=docker
cloud:=

app_port=3000
host_port:=3000

base_image_tag:=docker.io/library/node:17.0.1-alpine3.12

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
ifeq ("$(cloud)",$(filter "$(cloud)","heroku"))
	$(error This command has not been completed. Please run `make cloud-install cloud=$(cloud)`)
else ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
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
	&& IMAGE_TAG=$(image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) build \
	&& echo 'Successfully built: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./docker/Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
endif

.PHONY: check
check: install

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
	&& IMAGE_TAG=$(image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) up -d
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) run \
		--name $(container_name) \
		-d \
		-p $(host_port):$(app_port) \
		$(image_tag)
endif
	@echo 'Successfully started: http://localhost:$(host_port)'

.PHONY: stop
stop:
# nothing to do for "yarn" or "node" / "npm"
ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) down \
	&& echo 'Successfully removed container: $(container_name)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","podman" "docker"))
	@set -eu \
	&& $(dev_tool) rm -f $(container_name) \
	&& echo 'Successfully removed container: $(container_name)'
endif

.PHONY: clean
clean:
ifeq ("$(cloud)",$(filter "$(cloud)","heroku"))
	$(error This command has not been completed. Please run `make cloud-uninstall cloud=$(cloud)`)
else ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
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
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) rm -s -f \
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

.PHONY: cloud-validator
cloud-validator:
ifneq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud" "heroku"))
	$(error The "cloud" argument only supports "aws", "azure", "gcloud" or "heroku")
endif

.PHONY: cloud-init
cloud-init: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","heroku"))
	@make $(cloud)-init
endif

.PHONY: cloud-install
cloud-install: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","heroku"))
	@make $(cloud)-install
else
	$(error Deprecated. Please run `make install cloud=$(cloud)`)
endif

.PHONY: cloud-logs
cloud-logs: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","heroku"))
	@make $(cloud)-logs
else
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make logs; \
	cd $$prev_dir;
endif

.PHONY: cloud-uninstall
cloud-uninstall: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","heroku"))
	@make $(cloud)-uninstall
else
	$(error Deprecated. Please run `make uninstall cloud=$(cloud)`)
endif

.PHONY: heroku-init
heroku-init:
	@set -eu \
	&& heroku create \
		$(heroku_app_name) \
		--buildpack=https://github.com/lstoll/heroku-buildpack-monorepo \
	&& heroku buildpacks:add \
		-a $(heroku_app_name) \
		heroku/nodejs \
	&& heroku config:set \
		-a $(heroku_app_name) \
		APP_BASE=src/services/nodejs/expressjs/webapi/

.PHONY: heroku-install
heroku-install:
	@set -eu \
	&& git push https://git.heroku.com/$(heroku_app_name).git HEAD:main

.PHONY: heroku-logs
heroku-logs:
	@set -eu \
	&& heroku logs -a $(heroku_app_name)

.PHONY: heroku-uninstall
heroku-uninstall:
	@set -eu \
	&& heroku apps:destroy \
		-a $(heroku_app_name) \
		--confirm $(heroku_app_name)
