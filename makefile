dev_tool:=docker

docker_image_mkdocs_material_version:=7.3.4
docker_image_mkdocs_material_tag:=docker.io/squidfunk/mkdocs-material:$(docker_image_mkdocs_material_version)

project_dir=./src/nodejs/expressjs/webapi

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
		--rm \
		-i \
		-v $(shell pwd):/app \
		-w /app \
		mkdocs \
		build \
			--clean \
			--strict \
			--site-dir ./docs \
			--config-file ./mkdocs.yml

.PHONY: start-docs
start-docs: init
	@set -eu \
	&& $(dev_tool) run \
		--name our-hello-docs \
		-d \
		-v $(shell pwd):/app \
		-w /app \
		-p 8000:8000 \
		mkdocs \
		serve \
			-a 0.0.0.0:8000 \
			--livereload \
			--watch-theme \
			--config-file ./mkdocs.yml

.PHONY: stop-docs
stop-docs:
	@set -eu \
	&& $(dev_tool) rm -f our-hello-docs

.PHONY: install
install: install-docs
	@cd $(project_dir) \
	&& make $@

.PHONY: start
start:
	@cd $(project_dir) \
	&& make $@

.PHONY: stop
stop:
	@cd $(project_dir) \
	&& make $@

.PHONY: clean
clean:
	@cd $(project_dir) \
	&& make $@

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
