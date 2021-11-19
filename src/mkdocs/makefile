image_tag:=our-hello-mkdocs:latest

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
	@docker build \
		-t $(image_tag) \
		-f ./Dockerfile \
		.
