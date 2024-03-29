# docker | podman
dev_tool:=docker

image_name:=our-hello-tasks-aws-cli-dotnet-sdk

aws_version=2.4.7
eb_version=3.20.2
dotnet_version=6.0
dotnet_aws_deploy_version=0.31.11
image_tag:=$(image_name):$(aws_version)-eb$(eb_version)-dotnet$(dotnet_version)-awsdeploy$(dotnet_aws_deploy_version)
image_tag_yum_info:=$(image_name)-yum-info:latest

docker_push_registry:=ghcr.io
docker_push_organization_or_user:=ourchitecture
docker_push_repository:=hello-cloud
docker_push_image_tag:=$(docker_push_registry)/$(docker_push_organization_or_user)/$(docker_push_repository)/$(image_tag)

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
ifneq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	$(error The "$@" command target only supports "dev_tool=docker" or "dev_tool=podman")
endif
	@$(dev_tool) build \
		-t "$(image_tag)" \
		--build-arg AWS_CLI_VERSION=$(aws_version) \
		--build-arg EB_CLI_VERSION=$(eb_version) \
		--build-arg DOTNET_VERSION=$(dotnet_version) \
		--build-arg DOTNET_AWS_DEPLOY_CLI_VERSION=$(dotnet_aws_deploy_version) \
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

# NOTE: "entrypoint" is not used, because
# it would override the docker init script
.PHONY: debug
debug: install
	@$(dev_tool) run \
		--rm \
		--privileged \
		--interactive \
		--tty \
		"$(image_tag)" \
		/bin/bash

# Run a non-privileged (i.e. no `--privileged`) container.
# NOTE: "entrypoint" is not used, because
# it would override the docker init script
.PHONY: debug-basic
debug-basic: install
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		"$(image_tag)" \
		/bin/bash

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

.PHONY: install-yum-info
install-yum-info:
	@$(dev_tool) build \
		--target "yum_info" \
		-t "$(image_tag_yum_info)" \
		-f Dockerfile \
		.

.PHONY: check-package-info
check-package-info: install-yum-info
ifndef PACKAGE
	$(error Missing required argument "PACKAGE=[name]")
endif
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--entrypoint="yum" \
		"$(image_tag_yum_info)" \
		list installed $(PACKAGE)
# info $(PACKAGE)

.PHONY: check-versions
check-versions:
	@./check-versions.sh
