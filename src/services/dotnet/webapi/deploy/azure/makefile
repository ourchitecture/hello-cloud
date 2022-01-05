# docker | podman
dev_tool:=docker

az_version=2.30.0
image_name:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-azure-cli
image_tag:=$(image_name):$(az_version)

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
		./deploy/azure/install.sh
endif

.PHONY: status
status:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		az webapp log deployment show \
			--name "$$AZURE_APPSERVICE_NAME"
endif

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
		az webapp log show \
			--name "$$AZURE_APPSERVICE_NAME"
endif

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this Azure Resource group.)
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
		./deploy/azure/uninstall.sh
endif

uninstall: clean
