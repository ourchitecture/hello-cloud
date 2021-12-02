dev_tool:=docker
cloud:=azure

app_port=3000
host_port:=3000

base_image_tag:=docker.io/library/node:17.0.1-alpine3.12

container_name:=our-hello-nodejs-expressjs-webapi
image_tag:=our-hello-nodejs-expressjs-webapi:latest

docker_push_registry:=ghcr.io
docker_push_organization_or_user:=ourchitecture
docker_push_repository:=hello-cloud
docker_push_image_tag:=$(docker_push_registry)/$(docker_push_organization_or_user)/$(docker_push_repository)/$(image_tag)

aws_app_name:=app-our-hello-nodejs-expressjs-webapi
aws_environment_name:=env-our-hello-nodejs-expressjs

aws_app_name:=app-our-hello-nodejs-expressjs-webapi
aws_env_name:=env-our-hello-nodejs-expressjs
aws_platform:=node.js-14
aws_region:=us-east-1

azure_app_name:=app-our-hello-nodejs-expressjs-webapi
azure_rg:=rg-our-hello-cloud-expressjs
azure_region:=centralus

gcloud_project_name:=ourhelloexpress
gcloud_project_name_suffix:=001
gcloud_project_unique_name:=$(gcloud_project_name)$(gcloud_project_name_suffix)
gcloud_region:=us-east1
gcloud_logs_limit:=20

heroku_app_name:=our-hellonodejsexpressjswebapi

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
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
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./docker/Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
endif

.PHONY: check
check: install

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
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) run \
		--name $(container_name) \
		-d \
		-p $(host_port):$(app_port) \
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
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) rmi -f $(image_tag) \
	&& echo 'Successfully removed image: $(image_tag)'
endif

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
	&& $(dev_tool) tag $(image_tag) $(docker_push_image_tag) \
	&& cat "${DOCKER_PASSWORD_FILE_PATH}" \
		| $(dev_tool) login $(docker_push_registry) \
			--username "${DOCKER_USERNAME}" \
			--password-stdin \
	&& $(dev_tool) push $(docker_push_image_tag)

# convenience aliases
build: install
test: check
up: start
run: start
serve: start
down: stop
uninstall: clean

.PHONY: sync
sync:
	@git-town sync

.PHONY: cloud-validator
cloud-validator:
ifneq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud" "heroku"))
	$(error The "cloud" argument only supports "aws", "azure", "gcloud", or "heroku")
endif

.PHONY: cloud-init
cloud-init: cloud-validator
	@make $(cloud)-init

.PHONY: cloud-install
cloud-install: cloud-validator
	@make $(cloud)-install

.PHONY: cloud-logs
cloud-logs: cloud-validator
	@make $(cloud)-logs

.PHONY: cloud-uninstall
cloud-uninstall: cloud-validator
	@make $(cloud)-uninstall

.PHONY: requires-yarn
requires-yarn:
ifneq ("$(dev_tool)",$(filter "$(dev_tool)","yarn" "node" "npm"))
	$(error The "$@" command target only supports "dev_tool=yarn", "dev_tool=node" or "dev_tool=npm")
endif

.PHONY: aws-init
aws-init: requires-yarn
	@AWS_ENV_NAME="$(aws_environment_name)" \
	AWS_APP_NAME="$(aws_app_name)" \
	AWS_PLATFORM="$(aws_platform)" \
	AWS_PLATFORM_ARN="$(aws_platform_arn)" \
	AWS_REGION="$(aws_region)" \
	./aws-init.sh

.PHONY: aws-deploy
aws-deploy: requires-yarn
	@set -eu && eb deploy

.PHONY: aws-install
aws-install: requires-yarn install aws-init aws-deploy aws-status

.PHONY: aws-status
aws-status:
	@set -eu \
	&& eb status

.PHONY: aws-logs
aws-logs:
	@set -eu \
	&& eb logs

# BUG: uninstalling deletes the configuration file
#      so, this always copies the config file back
#      after the uninstall
.PHONY: aws-uninstall
aws-uninstall:
	@AWS_ENV_NAME="$(aws_environment_name)" \
	AWS_REGION="$(aws_region)" \
	./aws-uninstall.sh

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

# TODO: how to show recent application log entries?
.PHONY: azure-logs
azure-logs:
	@set -eu \
	&& az webapp log deployment show \
		--name $(azure_app_name)
	&& az webapp log show \
		--name $(azure_app_name)

.PHONY: azure-uninstall
azure-uninstall:
	@set -eu \
	&& az group delete \
		--name $(azure_rg) \
		--yes

.PHONY: gcloud-init
gcloud-init:
	@set -eu \
	&& gcloud projects create \
		"$(gcloud_project_unique_name)" \
		--quiet \
	&& gcloud config set project \
		"$(gcloud_project_unique_name)" \
		--quiet \
	&& gcloud app create \
		--region=$(gcloud_region) \
		--quiet

.PHONY: gcloud-install
gcloud-install:
	@set -eu \
	&& gcloud app deploy \
		./app.yaml \
		--stop-previous-version \
		--promote \
		--quiet

.PHONY: gcloud-logs
gcloud-logs:
	@set -eu \
	&& gcloud logging read \
		--project=$(gcloud_project_unique_name) \
		 --limit=$(gcloud_logs_limit)

.PHONY: gcloud-uninstall
gcloud-uninstall:
	@set -eu \
	&& gcloud projects delete \
		"$(gcloud_project_unique_name)" \
		--quiet

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
		APP_BASE=src/services/nodejs/expressjs/webapi/

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
