ARG BASE_DOCKER_IMAGE_NAME="mcr.microsoft.com/azure-cli"

ARG AZ_CLI_VERSION="2.31.0"

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_DOCKER_IMAGE_NAME}:${AZ_CLI_VERSION} as base

USER root

# disable telemetry
ENV AZURE_CORE_COLLECT_TELEMETRY=false

ENTRYPOINT []

FROM base as production

ARG PUBLISHED_SOURCE_URL
ARG PUBLISHED_DOCUMENTATION_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}
LABEL org.opencontainers.image.description "Tools for deploying applications to Microsoft Azure"

WORKDIR /app
