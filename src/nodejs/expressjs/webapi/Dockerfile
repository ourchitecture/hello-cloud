ARG BASE_DOCKER_IMAGE_NAME=docker.io/library/node
ARG NODE_VERSION=17.0.1
ARG ALPINE_VERSION=3.12
ARG BASE_DOCKER_IMAGE_TAG=${NODE_VERSION}-alpine${ALPINE_VERSION}

ARG PUBLISHED_SOURCE=https://github.com/ericis/hello-cloud

FROM ${BASE_DOCKER_IMAGE_NAME}:${BASE_DOCKER_IMAGE_TAG} as base

FROM base as dependencies

WORKDIR /app

COPY package.json yarn.lock .yarnrc /app/
COPY .yarn/ /app/.yarn/

RUN yarn --frozen-lockfile

FROM dependencies as production

ARG PUBLISHED_SOURCE

LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE}

COPY . /app/

WORKDIR /app

ENTRYPOINT [ "node", "./index.js" ]
