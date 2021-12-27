ARG BASE_BUILDER_DOCKER_IMAGE_NAME=docker.io/squidfunk/mkdocs-material

ARG MKDOCS_MATERIAL_VERSION=8.1.3

FROM ${BASE_BUILDER_DOCKER_IMAGE_NAME}:${MKDOCS_MATERIAL_VERSION} as base

WORKDIR /app

# FROM base as plugins
# FUTURE: option to add OS dependencies and `pip` mkdocs plug-ins
# RUN apk add --no-cache ...
# RUN pip install ...

# FROM plugins as production
FROM base as production
