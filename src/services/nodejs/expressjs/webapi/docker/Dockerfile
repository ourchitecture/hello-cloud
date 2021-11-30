ARG BASE_DOCKER_IMAGE_NAME=docker.io/library/node
ARG NODE_VERSION=17.0.1
ARG ALPINE_VERSION=3.12
ARG BASE_DOCKER_IMAGE_TAG=${NODE_VERSION}-alpine${ALPINE_VERSION}

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

ARG HTTP_PORT=3000

FROM ${BASE_DOCKER_IMAGE_NAME}:${BASE_DOCKER_IMAGE_TAG} as base

FROM base as dependencies

WORKDIR /app

COPY package.json yarn.lock .yarnrc /app/
COPY .yarn/ /app/.yarn/

RUN yarn --frozen-lockfile

FROM dependencies as production

ARG PUBLISHED_DOCUMENTATION_URL
ARG PUBLISHED_SOURCE_URL

ARG HTTP_PORT

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}

COPY . /app/

WORKDIR /app

EXPOSE ${HTTP_PORT}

ENTRYPOINT [ "node", "./index.js" ]
