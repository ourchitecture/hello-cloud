project_dir=./src/nodejs/expressjs/webapi

.DEFAULT_GOAL:=install

all: install

.PHONY: install
install:
	@cd $(project_dir) \
	&& make $@

.PHONY: up
up:
	@cd $(project_dir) \
	&& make $@

.PHONY: down
down:
	@cd $(project_dir) \
	&& make $@

.PHONY: clean
clean:
	@cd $(project_dir) \
	&& make $@

# convenient alias
.PHONY: uninstall
uninstall: clean

.PHONY: start
start: up

# convenient alias
.PHONY: run
run: up

# convenient alias
.PHONY: serve
serve: up
