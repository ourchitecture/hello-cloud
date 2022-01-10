# docker | podman
dev_tool:=docker

image_name:=our-hello-tasks-aws-cli

aws_version=2.4.7
eb_version=3.20.2
image_tag:=$(image_name):$(aws_version)-eb$(eb_version)
image_tag_base:=$(image_name)-base:latest

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
		--build-arg AWS_CLI_VERSION=$(aws_version) \
		--build-arg EB_CLI_VERSION=$(eb_version) \
		-f Dockerfile \
		. \
	&& $(dev_tool) tag "$(image_tag)" "$(docker_push_image_tag)" \
	&& echo 'Tagged as: $(docker_push_image_tag)'

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

.PHONY: install-base
install-base:
	@$(dev_tool) build \
		--target "base" \
		-t "$(image_tag_base)" \
		-f Dockerfile \
		.

.PHONY: debug-base
debug-base: install-base
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--entrypoint=/bin/bash \
		"$(image_tag_base)"

# NOTE: this is useful to check commands in the base image
#   e.g. Which packages are already installed?
#        `make debug-base-command yum list installed`
#   e.g. Info about a package, like version, release and architecture?
#        `make debug-base-command yum info yum-utils`
.PHONY: debug-base-command
debug-base-command: install-base
ifndef CMD
	$(error Missing required argument "CMD=[command]")
endif
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		"$(image_tag_base)" \
		$(CMD)

.PHONY: debug-command
debug-command: install
ifndef CMD
	$(error Missing required argument "CMD=[command]")
endif
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		"$(image_tag)" \
		$(CMD)

.PHONY: check-versions
check-versions:
	@./check-versions.sh
