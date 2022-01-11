# docker | podman
dev_tool:=docker

image_name:=our-hello-tasks-puppeteer

puppeteer_version=latest
image_tag:=$(image_name):$(puppeteer_version)

docker_push_registry:=ghcr.io
docker_push_organization_or_user:=ourchitecture
docker_push_repository:=hello-cloud
docker_push_image_tag:=$(docker_push_registry)/$(docker_push_organization_or_user)/$(docker_push_repository)/$(image_tag)

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
	@$(dev_tool) build \
		-t "$(image_tag)" \
		--build-arg MKDOCS_MATERIAL_VERSION=$(puppeteer_version) \
		-f Dockerfile \
		. \
	&& $(dev_tool) tag "$(image_tag)" "$(docker_push_image_tag)"

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
	&& cat "${DOCKER_PASSWORD_FILE_PATH}" \
		| $(dev_tool) login "$(docker_push_registry)" \
			--username "${DOCKER_USERNAME}" \
			--password-stdin \
	&& $(dev_tool) push "$(docker_push_image_tag)"

.PHONY: debug
debug: install
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/app \
		--volume "$(shell pwd)"/screenshots:/screenshots \
		--entrypoint=/bin/bash \
		"$(image_tag)"

.PHONY: check-version
check-version: install
ifndef CMD
	$(error The argument "CMD=..." is required.)
endif
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		"$(image_tag)" \
		$(CMD) --version

.PHONY: check-versions
check-versions:
	@./check-versions.sh

.PHONY: check
check: install
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)":/app \
		--volume "$(shell pwd)"/screenshots:/screenshots \
		--workdir /app \
		"$(image_tag)" \
		node ./test.js \
	&& echo 'WARNING: sudo is required to change ownership of the generated screenshot files from within the container to the host system' \
	&& sudo chown -R $$(whoami) ./screenshots

.PHONY: clean
clean:
	rm -rf ./screenshots
