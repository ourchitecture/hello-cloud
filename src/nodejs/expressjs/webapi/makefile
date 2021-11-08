dev_tool:=docker

app_port=3000
host_port:=3000

base_image_tag:=docker.io/library/node:17.0.1-alpine3.12

container_name:=our-hello-nodejs-expressjs-webapi
image_tag:=our-hello-nodejs-expressjs-webapi:latest

azure_app_name:=app-our-hello-nodejs-expressjs-webapi

heroku_app_name:=our-hellonodejsexpressjswebapi

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
# nothing to do for "docker-compose"
ifeq '$(dev_tool)' 'yarn'
	@set -eu \
	&& yarn
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","node" "npm"))
	@set -eu \
	&& npm install
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) build \
	&& echo 'Successfully built: $(image_tag)'
else
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
endif

.PHONY: start
start: install
ifeq '$(dev_tool)' 'yarn'
	@set -eu \
	&& yarn start
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","node" "npm"))
	@set -eu \
	&& npm start
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) up -d
else
	@set -eu \
	&& $(dev_tool) run \
		--name $(container_name) \
		-d \
		-p $(app_port):$(host_port) \
		$(image_tag)
endif
	@echo 'Successfully started: http://localhost:$(host_port)'

.PHONY: stop
stop:
# nothing to do for "yarn" or "node" / "npm"
ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) down \
	&& echo 'Successfully removed container: $(container_name)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","podman" "docker"))
	@set -eu \
	&& $(dev_tool) rm -f $(container_name) \
	&& echo 'Successfully removed container: $(container_name)'
endif

.PHONY: clean
clean:
# removing "package-lock.json" for local dev "node" / "npm" use,
# but not "yarn.lock" used by the project
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","yarn" "node" "npm"))
	@set -eu \
	&& rm -rf node_modules/ package-lock.json
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) rm -s -f \
	&& echo 'Successfully removed image: $(image_tag)'
else
	@set -eu \
	&& $(dev_tool) rmi -f $(image_tag) \
	&& echo 'Successfully removed image: $(image_tag)'
endif

# convenience aliases
build: install
up: start
run: start
serve: start
down: stop
uninstall: clean

.PHONY: sync
sync:
	@git-town sync

azure_rg:=rg-our-hello-cloud
azure_region:=centralus

.PHONY: azure-init
azure-init:
	@set -eu \
	&& az group create \
		--name $(azure_rg) \
		--location $(azure_region) \
	&& az config set \
		defaults.group=$(azure_rg) \
		defaults.location=$(azure_region)

.PHONY: azure-install
azure-install:
	@set -eu \
	&& az config set \
		defaults.group=$(azure_rg) \
		defaults.location=$(azure_region) \
	&& az webapp up \
		--name $(azure_app_name)

.PHONY: azure-logs
azure-logs:
	@set -eu \
	&& az webapp log tail \
		--name $(azure_app_name)

.PHONY: azure-uninstall
azure-uninstall:
	@set -eu \
	&& az group delete \
		--name $(azure_rg) \
		--yes

.PHONY: heroku-init
heroku-init:
	@set -eu \
	&& heroku create \
		$(heroku_app_name) \
		--buildpack=https://github.com/lstoll/heroku-buildpack-monorepo \
	&& heroku buildpacks:add \
		-a $(heroku_app_name) \
		heroku/nodejs \
	&& heroku config:set \
		-a $(heroku_app_name) \
		APP_BASE=src/nodejs/expressjs/webapi/

.PHONY: heroku-install
heroku-install:
	@set -eu \
	&& git push https://git.heroku.com/$(heroku_app_name).git HEAD:main

.PHONY: heroku-logs
heroku-logs:
	@set -eu \
	&& heroku logs -a $(heroku_app_name)

.PHONY: heroku-uninstall
heroku-uninstall:
	@set -eu \
	&& heroku apps:destroy \
		-a $(heroku_app_name) \
		--confirm $(heroku_app_name)
