az_version=2.30.0
image_tag:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-azure-cli:$(az_version)

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/azure/install.sh

.PHONY: status
status:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		az webapp log deployment show \
			--name "$$AZURE_APPSERVICE_NAME"

.PHONY: logs
logs:
	@docker run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		az webapp log show \
			--name "$$AZURE_APPSERVICE_NAME"

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this Azure Resource group.)
	$(error If you wish to continue, append ` confirm=1` to the end of the command.)
endif
	@docker run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/azure/uninstall.sh

uninstall: clean
