# docker | podman
dev_tool:=docker
cloud:=

# see: "./Properties/launchSettings.json"
#      .profiles.webapi.applicationUrl
#      Ports should match for consistency.
# TODO: https
# read: https://docs.microsoft.com/en-us/aspnet/core/security/docker-https?view=aspnetcore-6.0
# read: https://docs.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-6.0
app_http_port=8080
host_http_port:=5124
# app_https_port=443
# host_https_port:=7032

container_name:=our-hello-dotnet-webapi
image_tag:=our-hello-dotnet-webapi:latest

docker_push_registry:=ghcr.io
docker_push_organization_or_user:=ourchitecture
docker_push_repository:=hello-cloud
docker_push_image_tag:=$(docker_push_registry)/$(docker_push_organization_or_user)/$(docker_push_repository)/$(image_tag)

gcloud_project_name:=ourhellodotnet
gcloud_project_name_suffix:=001
gcloud_project_unique_name:=$(gcloud_project_name)$(gcloud_project_name_suffix)
gcloud_region:=us-east1
gcloud_logs_limit:=20

heroku_app_name:=our-hellodotnetwebapi

.DEFAULT_GOAL:=install

all: install

# TODO: cloud install for "heroku"
.PHONY: install
install:
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make $@; \
	cd $$prev_dir;
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) build \
		-t $(image_tag) \
		-f ./Dockerfile \
		. \
	&& echo 'Successfully built: $(image_tag)'
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(image_tag) \
	APP_HTTP_PORT=$(app_http_port) \
	HOST_HTTP_PORT=$(host_http_port) \
	$(dev_tool) build \
	&& echo 'Successfully built: $(image_tag)'
else ifeq '$(dev_tool)' 'dotnet'
	@set -eu \
	&& dotnet build --nologo
endif

.PHONY: check
check:
ifeq '$(dev_tool)' 'dotnet'
	@set -eu \
	&& dotnet test --nologo
endif

.PHONY: check-versions
check-versions:
	@./check-versions.sh

.PHONY: start
start: install
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) run \
		--name=$(container_name) \
		--detach \
		--publish $(host_http_port):$(app_http_port) \
		$(image_tag)
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(image_tag) \
	APP_HTTP_PORT=$(app_http_port) \
	HOST_HTTP_PORT=$(host_http_port) \
	$(dev_tool) up --detach
else ifeq '$(dev_tool)' 'dotnet'
	@set -eu \
	&& dotnet run --nologo
endif
	@echo 'Successfully started: http://localhost:$(host_http_port)'

.PHONY: stop
stop:
# nothing to do for "gradle"
ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_HTTP_PORT=$(app_http_port) \
	HOST_HTTP_PORT=$(host_http_port) \
	$(dev_tool) down \
	&& echo 'Successfully removed container: $(container_name)'
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","podman" "docker"))
	@set -eu \
	&& $(dev_tool) rm -f $(container_name) \
	&& echo 'Successfully removed container: $(container_name)'
endif

# TODO: cloud=heroku
.PHONY: logs
logs:
# TODO: docker container logs
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make $@; \
	cd $$prev_dir;
endif

# TODO: cloud=heroku
.PHONY: clean
clean:
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
	@prev_dir=$(shell pwd); \
	cd ./deploy/$(cloud) && make $@; \
	cd $$prev_dir;
else ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@set -eu \
	&& $(dev_tool) rmi -f $(image_tag)
else ifeq '$(dev_tool)' 'docker-compose'
	@set -eu \
	&& IMAGE_TAG=$(base_image_tag) \
	APP_HTTP_PORT=$(app_http_port) \
	HOST_HTTP_PORT=$(host_http_port) \
	$(dev_tool) rm -s -f \
	&& echo 'Successfully removed image: $(image_tag)'
else ifeq '$(dev_tool)' 'dotnet'
	@set -eu \
	&& rm -rf ./bin/ ./obj/
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
restart: stop start

# TODO: migrate to `make install cloud=...` and `make uninstall cloud=...`
.PHONY: cloud-validator
cloud-validator:
ifneq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud" "heroku"))
	$(error The "cloud" argument only supports "azure" "gcloud", or "heroku")
endif

# TODO: migrate to `make install cloud=...`
.PHONY: cloud-init
cloud-init: cloud-validator
ifeq '$(cloud)' 'heroku'
	@make $(cloud)-init
endif

# TODO: migrate to `make install cloud=...`
.PHONY: cloud-install
cloud-install: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
	@make install cloud=$(cloud)
else
	@make $(cloud)-install
endif

# TODO: migrate to `make logs cloud=...`
.PHONY: cloud-logs
cloud-logs: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
	@make logs cloud=$(cloud)
else
	@make $(cloud)-logs
endif

# TODO: migrate to `make uninstall cloud=...`
.PHONY: cloud-uninstall
cloud-uninstall: cloud-validator
ifeq ("$(cloud)",$(filter "$(cloud)","aws" "azure" "gcloud"))
	@make clean cloud=$(cloud)
else
	@make $(cloud)-uninstall
endif

# TODO: migrate to `make install cloud=heroku`
.PHONY: heroku-init
heroku-init:
	@set -eu \
	&& heroku create \
		$(heroku_app_name) \
		--buildpack=https://github.com/lstoll/heroku-buildpack-monorepo \
	&& heroku buildpacks:add \
		-a $(heroku_app_name) \
		https://github.com/jincod/dotnetcore-buildpack \
	&& heroku config:set \
		-a $(heroku_app_name) \
		APP_BASE=src/services/dotnet/webapi/

# TODO: migrate to `make install cloud=heroku`
.PHONY: heroku-install
heroku-install:
	@set -eu \
	&& git push https://git.heroku.com/$(heroku_app_name).git HEAD:main

# TODO: migrate to `make logs cloud=heroku`
.PHONY: heroku-logs
heroku-logs:
	@set -eu \
	&& heroku logs -a $(heroku_app_name)

# TODO: migrate to `make uninstall cloud=heroku`
.PHONY: heroku-uninstall
heroku-uninstall:
	@set -eu \
	&& heroku apps:destroy \
		-a $(heroku_app_name) \
		--confirm $(heroku_app_name)
