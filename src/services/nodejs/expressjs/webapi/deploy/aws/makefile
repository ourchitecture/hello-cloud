aws_version=2.4.4
eb_version=3.20.2
image_tag:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-aws-cli:$(aws_version)-eb$(eb_version)

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
		./deploy/aws/install.sh

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
		eb status

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
		eb logs

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this AWS Environment.)
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
		./deploy/aws/uninstall

uninstall: clean
