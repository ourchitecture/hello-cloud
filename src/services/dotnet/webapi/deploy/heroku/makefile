image_tag:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-heroku-cli:latest

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
		./deploy/heroku/install.sh

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
		./deploy/heroku/logs.sh

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this Heroku application.)
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
		./deploy/heroku/uninstall

uninstall: clean
