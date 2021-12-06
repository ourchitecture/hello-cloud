ARG BASE_DOCKER_IMAGE_NAME=docker.io/library/node
ARG NODE_VERSION=16.13.1
ARG ALPINE_VERSION=3.12
ARG BASE_DOCKER_IMAGE_TAG=${NODE_VERSION}-alpine${ALPINE_VERSION}

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

ARG HTTP_PORT=3000

FROM ${BASE_DOCKER_IMAGE_NAME}:${BASE_DOCKER_IMAGE_TAG} as base

FROM base as packages

RUN apk add --no-cache \
      curl

FROM packages as dependencies

WORKDIR /app

COPY package.json yarn.lock .yarnrc.yml /app/
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

ENV HTTP_PORT=${HTTP_PORT}

EXPOSE ${HTTP_PORT}

# override with: https://docs.docker.com/engine/reference/run/#healthcheck
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s \
  CMD curl --fail "http://localhost:${HTTP_PORT}" || exit 1

ENTRYPOINT [ "node", "./index.js" ]
