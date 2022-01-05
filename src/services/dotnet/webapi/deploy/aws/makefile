# docker | podman
dev_tool:=docker

aws_version:=2.4.7
eb_version:=3.20.2
dotnet_version:=6.0
dotnet_aws_deploy_version:=0.31.11
image_name:=ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-aws-cli-dotnet-sdk
image_tag:=$(image_name):$(aws_version)-eb$(eb_version)-dotnet$(dotnet_version)-awsdeploy$(dotnet_aws_deploy_version)

.DEFAULT_GOAL:=install

all: install

# NOTE: "--privileged" is required, because deployment uses `docker`.
#  This may not be required for other commands.
.PHONY: install
install:
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@$(dev_tool) run \
		--rm \
		--privileged \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/aws/install.sh
endif

.PHONY: status
status:
	@set -eu \
	&& echo '' \
	&& echo 'Status and logs are available in the online console at:' \
	&& echo 'https://console.aws.amazon.com/apprunner/home' \
	&& echo 'Select the region and deployed service to check the status' \
	&& echo '' \
	&& echo 'Developers wanted! Contribute an automated CLI command option for deployment status here.'

.PHONY: logs
logs:
	@set -eu \
	&& echo '' \
	&& echo 'Status and logs are available in the online console at:' \
	&& echo 'https://console.aws.amazon.com/apprunner/home' \
	&& echo 'Select the region and deployed service and then navigate to "Logs" and "Application Logs"' \
	&& echo '' \
	&& echo 'Developers wanted! Contribute an automated CLI command option for streaming logs here.'

.PHONY: clean
clean:
ifneq '$(confirm)' '1'
	$(warning Warning: you are about to completely delete this AWS Environment.)
	$(error If you wish to continue, append ` confirm=1` to the end of the command.)
endif
ifeq ("$(dev_tool)",$(filter "$(dev_tool)","docker" "podman"))
	@$(dev_tool) run \
		--rm \
		--interactive \
		--tty \
		--volume "$(shell pwd)/../../":/app \
		--workdir /app \
		--env-file ./.env \
		"$(image_tag)" \
		./deploy/aws/uninstall
endif

uninstall: clean
