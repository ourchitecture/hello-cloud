ARG MKDOCS_MATERIAL_VERSION=7.3.4
ARG DOCKER_IMAGE=docker.io/squidfunk/mkdocs-material

FROM ${DOCKER_IMAGE}:${MKDOCS_MATERIAL_VERSION}

RUN pip install --no-cache-dir \
    mkdocs-mermaid2-plugin

ENTRYPOINT ["mkdocs"]
