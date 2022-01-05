ARG DEBIAN_NAMED_RELEASE="bullseye"
ARG BASE_DOCKER_IMAGE_NAME="docker.io/library/debian"

ARG DEBIAN_VERSION="${DEBIAN_NAMED_RELEASE}-slim"

# get the version of an installed package with:
#   apt-cache policy ...
# https://www.debian.org/distrib/packages#search_packages ("stable" distribution)
ARG APT_VERSION_TRANSPORT_HTTPS="2.2.4"
ARG APT_VERSION_CA_CERTIFICATES="20210119"
ARG APT_VERSION_CURL="7.74.0-1.3+deb11u1"
ARG APT_VERSION_GIT="1:2.30.2-1"

ARG HEROKU_INSTALL_URL=https://cli-assets.heroku.com/install.sh

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_DOCKER_IMAGE_NAME}:${DEBIAN_VERSION} as base

FROM base as packages

ARG APT_VERSION_TRANSPORT_HTTPS
ARG APT_VERSION_CA_CERTIFICATES
ARG APT_VERSION_CURL
ARG APT_VERSION_GIT

# install packages with specific versions
RUN apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive \
      apt-get install -qqy --no-install-recommends \
        apt-transport-https=${APT_VERSION_TRANSPORT_HTTPS} \
        ca-certificates=${APT_VERSION_CA_CERTIFICATES} \
        curl=${APT_VERSION_CURL} \
        git=${APT_VERSION_GIT} \
    # clean up docker layer
    # https://docs.docker.com/develop/develop-images/dockerfile_best_practices/#run
    && rm -rf /var/lib/apt/lists/*

RUN git config --global init.defaultBranch main

FROM packages as heroku

ARG HEROKU_INSTALL_URL

# install heroku cli
# NOTE: it seems impossible to install a specific version of the cli
# So, this docker image will always be considered "latest".
RUN curl -o- "$HEROKU_INSTALL_URL" | /bin/sh \
    && heroku update

FROM heroku as production

ARG PUBLISHED_SOURCE_URL
ARG PUBLISHED_DOCUMENTATION_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}
LABEL org.opencontainers.image.description "Tools for deploying applications to Salesforce Heroku"

WORKDIR /app
