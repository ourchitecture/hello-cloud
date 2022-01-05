ARG BASE_BUILDER_DOCKER_IMAGE_NAME=docker.io/squidfunk/mkdocs-material

ARG MKDOCS_MATERIAL_VERSION=8.1.3

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_BUILDER_DOCKER_IMAGE_NAME}:${MKDOCS_MATERIAL_VERSION} as base

WORKDIR /app

# FROM base as plugins
# FUTURE: option to add OS dependencies and `pip` mkdocs plug-ins
# RUN apk add --no-cache ...
# RUN pip install ...

# FROM plugins as production
FROM base as production

ARG PUBLISHED_SOURCE_URL
ARG PUBLISHED_DOCUMENTATION_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}
LABEL org.opencontainers.image.description "Tools for building documentation websites with MkDocs"

