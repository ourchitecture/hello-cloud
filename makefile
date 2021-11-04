project_dir=./src/nodejs/expressjs/webapi

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
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
