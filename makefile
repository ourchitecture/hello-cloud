dev_tool:=docker

docker_image_mkdocs_material_version:=7.3.4
docker_image_mkdocs_material_tag:=docker.io/squidfunk/mkdocs-material:$(docker_image_mkdocs_material_version)

project_dirs=./src/services/java/springboot/webapi ./src/services/nodejs/expressjs/webapi

docs_app_port=8000
docs_host_port:=8000

docs_container_name:=our-hello-docs

.DEFAULT_GOAL:=install

all: install

.PHONY: init
init:
	@set -eu \
	&& $(dev_tool) pull $(docker_image_mkdocs_material_tag) \
	&& $(dev_tool) tag $(docker_image_mkdocs_material_tag) mkdocs

.PHONY: install-docs
install-docs: init
	@set -eu \
	&& $(dev_tool) run \
		--name $(docs_container_name)-$@ \
		--rm \
		-i \
		-v $(shell pwd):/app \
		-w /app \
		mkdocs \
		build \
			--clean \
			--site-dir ./docs \
			--config-file ./mkdocs.yml

.PHONY: start-docs
start-docs: init
	@set -eu \
	&& $(dev_tool) run \
		--name $(docs_container_name) \
		-d \
		-v $(shell pwd):/app \
		-w /app \
		-p $(docs_app_port):$(docs_host_port) \
		mkdocs \
		serve \
			-a 0.0.0.0:$(docs_app_port) \
			--livereload \
			--watch-theme \
			--config-file ./mkdocs.yml
	@echo 'Successfully started: http://localhost:$(docs_host_port)'

.PHONY: stop-docs
stop-docs:
	@set -eu \
	&& $(dev_tool) rm -f our-hello-docs

.PHONY: install
install: install-docs
	@set -eu; \
	for project_dir in $(project_dirs); do \
		prev_dir=$(shell pwd); \
		cd $$project_dir && make $@; \
		cd $$prev_dir; \
	done

.PHONY: start
start: start-docs
	@set -eu; \
	for project_dir in $(project_dirs); do \
		prev_dir=$(shell pwd); \
		cd $$project_dir && make $@; \
		cd $$prev_dir; \
	done

.PHONY: stop
stop: stop-docs
	@set -eu; \
	for project_dir in $(project_dirs); do \
		prev_dir=$(shell pwd); \
		cd $$project_dir && make $@; \
		cd $$prev_dir; \
	done

.PHONY: clean
clean:
	@set -eu; \
	for project_dir in $(project_dirs); do \
		prev_dir=$(shell pwd); \
		cd $$project_dir && make $@; \
		cd $$prev_dir; \
	done

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
