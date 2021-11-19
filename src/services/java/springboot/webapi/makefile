dev_tool:=docker
cloud:=azure

app_port=8080
host_port:=8080

container_name:=our-hello-java-springboot-webapi
image_tag:=our-hello-java-springboot-webapi:latest

docker_push_registry:=ghcr.io
docker_push_organization_or_user:=ourchitecture
docker_push_repository:=hello-cloud
docker_push_image_tag:=$(docker_push_registry)/$(docker_push_organization_or_user)/$(docker_push_repository)/$(image_tag)

aws_app_name:=app-our-hello-java-springboot-webapi
aws_env_name:=env-our-hello-java-springboot
aws_platform:=corretto-11
aws_region:=us-east-1

azure_app_plan_name:=plan-our-hello
azure_app_name:=app-our-hello-java-springboot-webapi
azure_rg:=rg-our-hello-cloud-springboot
azure_region:=centralus

gcloud_project_name:=ourhellospringboot
gcloud_project_name_suffix:=001
gcloud_project_unique_name:=$(gcloud_project_name)$(gcloud_project_name_suffix)
gcloud_region:=us-east1
gcloud_logs_limit:=20

heroku_app_name:=our-hellojavaspringbootwebapi

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./docker/Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) build \
	&& echo 'Successfully built: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","gradle" "gradlew"))
	@set -eu \
	&& ./gradlew build
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	@set -eu \
	&& ./mvnw package
endif

.PHONY: check
check:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./docker/Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","gradle" "gradlew"))
	@set -eu \
	&& ./gradlew test
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	@set -eu \
	&& ./mvnw test
endif

.PHONY: start
start: install
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) run \
		--name=$(container_name) \
		-d \
		-p $(host_port):$(app_port) \
		$(image_tag)
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) up -d
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","gradle" "gradlew"))
	@set -eu \
	&& ./gradlew bootRun
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	@set -eu \
	&& ./mvnw spring-boot:run
endif

.PHONY: stop
stop:
# nothing to do for "gradle"
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
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) rmi -f $(image_tag)
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_PORT=$(app_port) \
	HOST_PORT=$(host_port) \
	$(dev_tool) rm -s -f \
	&& echo 'Successfully removed image: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","gradle" "gradlew"))
	@set -eu \
	&& rm -rf \
		./.gradle/ \
		./bin/ \
		./build/
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	@set -eu \
	&& rm -rf \
		./target/
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

.PHONY: aws-init
aws-init:
	@set -eu \
	&& eb init $(aws_app_name) \
		--platform $(aws_platform) \
		--region $(aws_region) \
	&& eb create \
		--sample $(aws_env_name) \
	&& eb setenv SERVER_PORT=5000

.PHONY: aws-install
aws-install:
	@set -eu \
	&& eb deploy

.PHONY: aws-logs
aws-logs:
	@set -eu \
	&& eb logs

.PHONY: aws-uninstall
aws-uninstall:
	@set -eu \
	&& eb terminate \
		--force \
		--all

.PHONY: azure-init
azure-init:
	@set -eu \
	&& echo 'Creating Resource Group...' \
	&& az group create \
		--name $(azure_rg) \
		--location $(azure_region) \
	&& echo 'Resource Group successfully created.' \
	&& az config set \
		defaults.group=$(azure_rg) \
		defaults.location=$(azure_region) \
	&& echo 'Creating AppService Plan...' \
	&& az appservice plan create \
		--name $(azure_app_plan_name) \
		--is-linux \
		--sku B1 \
	&& echo 'AppService Plan successfully created.' \

# BUG: https://github.com/Azure/azure-cli/issues/20277
.PHONY: azure-install
azure-install:
ifneq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	$(error Only "dev_tool=maven" is supported for the target $@)
endif
	@make install
	@set -eu \
	&& az config set \
		defaults.group=$(azure_rg) \
		defaults.location=$(azure_region) \
	&& echo 'Deploying build artifact jar file to Azure Java web AppService...' \
    && ./mvnw azure-webapp:deploy \
        "-Dazure.resourcegroup=$(azure_rg)" \
        "-Dazure.region=$(azure_region)" \
        "-Dazure.appservice.name=$(azure_app_name)" \
        "-Dazure.appservice.name=$(azure_app_name)" \
        "-Dazure.appservice.plan.name=$(azure_app_plan_name)" \
	&& echo 'Java web app successfully deployed.'

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
	&& echo 'Deleting Resource Group, including child resources...' \
	&& az group delete \
		--name $(azure_rg) \
		--yes \
	&& echo 'Resource Group successfully deleted.'

.PHONY: gcloud-init
gcloud-init:
	@GCLOUD_PROJECT_NAME=$(gcloud_project_unique_name) \
	GCLOUD_REGION=$(gcloud_region) \
	./gcloud-init.sh

.PHONY: gcloud-install
gcloud-install:
	@set -eu \
	&& echo 'Deploying the application...' \
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
		heroku/java \
	&& heroku config:set \
		-a $(heroku_app_name) \
		APP_BASE=src/java/springboot/webapi/

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
