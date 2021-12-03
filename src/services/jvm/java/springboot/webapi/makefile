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
aws_environment_name:=env-our-hello-java-springboot
# BUG: there appears to be a later version of this platform
#      but, doesn't appear to be a way to specify it
#      e.g. `eb platform list` only displays "corretto-11"
aws_platform:=corretto-11
aws_platform_arn:=arn:aws:elasticbeanstalk:us-east-1::platform/Corretto 8 running on 64bit Amazon Linux 2/3.2.8
aws_region:=us-east-1

azure_resource_group:=rg-our-hello-cloud-springboot
azure_region:=centralus
azure_appservice_plan_name:=plan-our-hello
azure_appservice_plan_sku:=B1
azure_appservice_name:=app-our-hello-java-springboot-webapi

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
		-t "$(image_tag)" \
		-f ./docker/Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG="$(image_tag)" \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
	$(dev_tool) build \
	&& echo 'Successfully built: $(image_tag)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","gradle" "gradlew"))
	@set -eu \
	&& ./gradlew bootJar
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	@set -eu \
	&& ./mvnw clean package
endif

.PHONY: check
check:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t "$(image_tag)" \
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
		--name="$(container_name)" \
		-d \
		-p $(host_port):$(app_port) \
		"$(image_tag)" \
	&& echo 'Successfully started: http://localhost:$(host_port)'
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG="$(image_tag)" \
		APP_PORT="$(app_port)" \
		HOST_PORT="$(host_port)" \
		$(dev_tool) up -d \
	&& echo 'Successfully started: http://localhost:$(host_port)'
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
	&& IMAGE_TAG="$(base_image_tag)" \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
	$(dev_tool) down \
	&& echo 'Successfully removed container: $(container_name)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","podman" "docker"))
	@set -eu \
	&& $(dev_tool) rm -f "$(container_name)" \
	&& echo 'Successfully removed container: $(container_name)'
endif

.PHONY: clean
clean:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) rmi -f "$(image_tag)"
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG="$(base_image_tag)" \
	APP_PORT="$(app_port)" \
	HOST_PORT="$(host_port)" \
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
	&& $(dev_tool) tag "$(image_tag)" "$(docker_push_image_tag)" \
	&& cat "${DOCKER_PASSWORD_FILE_PATH}" \
		| $(dev_tool) login "$(docker_push_registry)" \
			--username "${DOCKER_USERNAME}" \
			--password-stdin \
	&& $(dev_tool) push "$(docker_push_image_tag)"

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
	@AWS_ENV_NAME="$(aws_environment_name)" \
	AWS_APP_NAME="$(aws_app_name)" \
	AWS_PLATFORM="$(aws_platform)" \
	AWS_PLATFORM_ARN="$(aws_platform_arn)" \
	AWS_REGION="$(aws_region)" \
	./aws-init.sh

.PHONY: requires-gradle
requires-gradle:
ifneq ("$(dev_tool)",$(filter "$(dev_tool)","gradle" "gradlew"))
	$(error The "$@" command target only supports "dev_tool=gradle" or "dev_tool=gradlew")
endif

.PHONY: requires-maven
requires-maven:
ifneq ("$(dev_tool)",$(filter "$(dev_tool)","maven" "mvn" "mvnw"))
	$(error The "$@" command target only supports "dev_tool=maven", "dev_tool=mvn", or "dev_tool=mvnw")
endif

.PHONY: aws-deploy
aws-deploy:
	@set -eu && eb deploy

.PHONY: aws-install
aws-install: requires-gradle install aws-init aws-deploy aws-status

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
	@AZURE_RESOURCE_GROUP="$(azure_resource_group)" \
	AZURE_REGION="$(azure_region)" \
	AZURE_APPSERVICE_PLAN_NAME="$(azure_appservice_plan_name)" \
	AZURE_APPSERVICE_PLAN_SKU="$(azure_appservice_plan_sku)" \
	./azure-init.sh

# BUG: https://github.com/Azure/azure-cli/issues/20277
.PHONY: azure-install
azure-install: requires-maven install azure-init
	@AZURE_RESOURCE_GROUP="$(azure_resource_group)" \
	AZURE_REGION="$(azure_region)" \
	AZURE_APPSERVICE_PLAN_NAME="$(azure_appservice_plan_name)" \
	AZURE_APPSERVICE_NAME="$(azure_appservice_name)" \
	./azure-install.sh

# TODO: how to show recent application log entries?
.PHONY: azure-logs
azure-logs:
	@set -eu \
	&& az webapp log deployment show \
		--name "$(azure_appservice_name)"
	&& az webapp log show \
		--name "$(azure_appservice_name)"

.PHONY: azure-uninstall
azure-uninstall:
	@set -eu \
	&& echo 'Deleting Azure Resource Group, including child resources...' \
	&& az group delete \
		--name "$(azure_resource_group)" \
		--yes \
	&& echo 'Successfully deleted Azure Resource Group.'

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
		APP_BASE=src/jvm/java/springboot/webapi/

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
