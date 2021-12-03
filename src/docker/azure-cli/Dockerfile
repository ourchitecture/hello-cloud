ARG BASE_DOCKER_IMAGE_NAME="mcr.microsoft.com/azure-cli"

ARG AZ_CLI_VERSION="2.30.0"

FROM ${BASE_DOCKER_IMAGE_NAME}:${AZ_CLI_VERSION} as base

USER root

# disable telemetry
ENV AZURE_CORE_COLLECT_TELEMETRY=false

ENTRYPOINT []

FROM base as production

WORKDIR /app
