# docker | podman
dev_tool:=docker

gcloud_version=365.0.1
image_name:=google/cloud-sdk
image_tag:=$(image_name):$(gcloud_version)-alpine

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/gcloud/install.sh
endif

# TODO: status

.PHONY: logs
logs:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/gcloud/logs.sh
endif

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this Google Project.)
	$(error If you wish to continue, append ` confirm=1` to the end of the command.)
endif
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/gcloud/uninstall
endif

uninstall: clean
