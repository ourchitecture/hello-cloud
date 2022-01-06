gcloud_version=365.0.1
image_tag:=google/cloud-sdk:$(gcloud_version)-alpine

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
		./deploy/gcloud/install.sh

# TODO: status

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
		./deploy/gcloud/logs.sh

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this Google project.)
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
		./deploy/gcloud/uninstall

uninstall: clean
