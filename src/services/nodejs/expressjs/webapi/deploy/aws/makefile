# docker | podman
dev_tool:=docker

aws_version:=2.4.4
eb_version:=3.20.2
image_name:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-aws-cli
image_tag:=$(image_name):$(aws_version)-eb$(eb_version)

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
		./deploy/aws/install.sh
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
		eb status
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
		eb logs
endif

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this AWS Environment.)
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
		./deploy/aws/uninstall
endif

uninstall: clean
