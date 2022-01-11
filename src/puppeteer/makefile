# docker | podman
dev_tool:=docker

puppeteer_version:=latest
image_name:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-puppeteer
image_tag:=$(image_name):$(puppeteer_version)

.DEFAULT_GOAL:=check

all: check

.PHONY: check
check: clean
	@IMAGE_TAG="$(image_tag)" \
	./start.sh \
	&& echo 'WARNING: sudo is required to change ownership of the generated screenshot files from within the container to the host system' \
	&& sudo chown -R $$(whoami) ./screenshots

.PHONY: clean
clean:
	@rm -rf ./screenshots
