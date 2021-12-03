ARG BASE_DOCKER_IMAGE_NAME="docker.io/amazon/aws-cli"

ARG AWS_CLI_VERSION="2.4.4"

ARG EB_CLI_VERSION="3.20.2"

ARG YUM_ARCH="x86_64"
ARG YUM_GROUP_DEV_TOOLS="Development Tools"
ARG YUM_PACKAGE_ZLIB="zlib-devel-1.2.7-18.amzn2.${YUM_ARCH}"
ARG YUM_PACKAGE_OPENSSL="openssl-devel-1.0.2k-19.amzn2.0.10.${YUM_ARCH}"
ARG YUM_PACKAGE_NCURSES="ncurses-devel-6.0-8.20170212.amzn2.1.3.${YUM_ARCH}"
ARG YUM_PACKAGE_LIBFFI="libffi-devel-3.0.13-18.amzn2.0.2.${YUM_ARCH}"
ARG YUM_PACKAGE_SQLITE="sqlite-devel-3.7.17-8.amzn2.1.1.${YUM_ARCH}"
ARG YUM_PACKAGE_READLINE="readline-devel-6.2-10.amzn2.0.2.${YUM_ARCH}"
ARG YUM_PACKAGE_BZIP="bzip2-devel-1.0.6-13.amzn2.0.3.${YUM_ARCH}"
ARG YUM_PACKAGE_PYTHON="python3-devel-3.7.10-1.amzn2.0.1.${YUM_ARCH}"
ARG YUM_PACKAGE_PIP="python3-pip-20.2.2-1.amzn2.0.3"
ARG YUM_PACKAGE_WHICH="which-2.20-7.amzn2.0.2.${YUM_ARCH}"

ARG NVM_VERSION="v0.34.0"
ARG NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh"

ARG NODE_VERSION="v16.13.1"

FROM ${BASE_DOCKER_IMAGE_NAME}:${AWS_CLI_VERSION} as base

SHELL ["/bin/bash", "-c"]

USER root

# disable telemetry
ENV SAM_CLI_TELEMETRY=0

ENTRYPOINT []

FROM base as yum_info

# this forces an Amazon repo database download
# that will be cached in the docker layer
# for faster "yum info ..." commands
RUN yum info zlib

FROM base as packages

ARG YUM_GROUP_DEV_TOOLS
ARG YUM_PACKAGE_ZLIB
ARG YUM_PACKAGE_OPENSSL
ARG YUM_PACKAGE_NCURSES
ARG YUM_PACKAGE_LIBFFI
ARG YUM_PACKAGE_SQLITE
ARG YUM_PACKAGE_READLINE
ARG YUM_PACKAGE_BZIP
ARG YUM_PACKAGE_PYTHON
ARG YUM_PACKAGE_PIP
ARG YUM_PACKAGE_WHICH

RUN yum --assumeyes group install "${YUM_GROUP_DEV_TOOLS}" \
    && yum --assumeyes install \
      ${YUM_PACKAGE_ZLIB} \
      ${YUM_PACKAGE_OPENSSL} \
      ${YUM_PACKAGE_NCURSES} \
      ${YUM_PACKAGE_LIBFFI} \
      ${YUM_PACKAGE_SQLITE} \
      ${YUM_PACKAGE_READLINE} \
      ${YUM_PACKAGE_BZIP} \
      ${YUM_PACKAGE_PYTHON} \
      ${YUM_PACKAGE_PIP} \
      ${YUM_PACKAGE_WHICH} \
    && yum -y clean all \
    && rm -rf /var/cache

FROM packages as eb

ARG EB_CLI_VERSION

WORKDIR /tmp

RUN pip3 install \
      awsebcli==${EB_CLI_VERSION} \
      --upgrade \
      --user

ENV PATH=/root/.local/bin/:${PATH}

FROM eb as production

WORKDIR /app

ENTRYPOINT []
