ARG BASE_DOCKER_IMAGE_NAME="docker.io/amazon/aws-cli"

ARG AWS_CLI_VERSION="2.4.7"

ARG EB_CLI_VERSION="3.20.2"

ARG YUM_ARCH="x86_64"

ARG YUM_GROUP_DEV_TOOLS="Development Tools"

# check for package upgrades with the command:
#   `make debug-base-command CMD="yum info [package-name]"`
# where, "[package-name]" is the name of the package (e.g. "yum info bzip2-devel")
ARG YUM_PACKAGE_BZIP="bzip2-devel-1.0.6-13.amzn2.0.3.${YUM_ARCH}"
# "iproute" does not use "-devel" suffix to install `ip` command
ARG YUM_PACKAGE_IPROUTE="iproute-4.15.0-1.amzn2.0.4.${YUM_ARCH}"
ARG YUM_PACKAGE_LIBFFI="libffi-devel-3.0.13-18.amzn2.0.2.${YUM_ARCH}"
ARG YUM_PACKAGE_NCURSES="ncurses-devel-6.0-8.20170212.amzn2.1.3.${YUM_ARCH}"
ARG YUM_PACKAGE_OPENSSL="openssl-devel-1.0.2k-19.amzn2.0.10.${YUM_ARCH}"
# "python3-pip" no arch suffix
ARG YUM_PACKAGE_PIP="python3-pip-20.2.2-1.amzn2.0.3"
ARG YUM_PACKAGE_PYTHON="python3-devel-3.7.10-1.amzn2.0.1.${YUM_ARCH}"
ARG YUM_PACKAGE_READLINE="readline-devel-6.2-10.amzn2.0.2.${YUM_ARCH}"
ARG YUM_PACKAGE_SQLITE="sqlite-devel-3.7.17-8.amzn2.1.1.${YUM_ARCH}"
ARG YUM_PACKAGE_WHICH="which-2.20-7.amzn2.0.2.${YUM_ARCH}"
# "yum-utils" no arch suffix
ARG YUM_PACKAGE_YUM_UTILS="yum-utils-1.1.31-46.amzn2.0.1"
ARG YUM_PACKAGE_ZLIB="zlib-devel-1.2.7-18.amzn2.${YUM_ARCH}"

ARG NVM_VERSION="v0.34.0"
ARG NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh"

ARG NODE_VERSION="v16.13.1"

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_DOCKER_IMAGE_NAME}:${AWS_CLI_VERSION} as base

SHELL ["/bin/bash", "-c"]

USER root

# disable AWS telemetry by default (opt-in)
# Contributors are welcome for disabling any other default tracking.
ENV SAM_CLI_TELEMETRY=0

ENTRYPOINT []

FROM base as packages

ARG YUM_GROUP_DEV_TOOLS

# NOTE: please try to keep these alphabetically sorted
ARG YUM_PACKAGE_BZIP
ARG YUM_PACKAGE_IPROUTE
ARG YUM_PACKAGE_LIBFFI
ARG YUM_PACKAGE_NCURSES
ARG YUM_PACKAGE_OPENSSL
ARG YUM_PACKAGE_PIP
ARG YUM_PACKAGE_PYTHON
ARG YUM_PACKAGE_READLINE
ARG YUM_PACKAGE_SQLITE
ARG YUM_PACKAGE_WHICH
ARG YUM_PACKAGE_YUM_UTILS
ARG YUM_PACKAGE_ZLIB

# BUG: yum simply skips over missing packages without an error
#       https://serverfault.com/a/694959
# NOTE: please try to keep the command groups alphabetically sorted
RUN yum update \
    && yum --assumeyes group install "${YUM_GROUP_DEV_TOOLS}" \
    && yum info ${YUM_PACKAGE_BZIP} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_IPROUTE} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_LIBFFI} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_NCURSES} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_OPENSSL} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_PIP} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_PYTHON} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_READLINE} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_SQLITE} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_WHICH} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_YUM_UTILS} >> /dev/null 2>&1 || exit \
    && yum info ${YUM_PACKAGE_ZLIB} >> /dev/null 2>&1 || exit \
    && yum --assumeyes install \
      ${YUM_PACKAGE_BZIP} \
      ${YUM_PACKAGE_IPROUTE} \
      ${YUM_PACKAGE_LIBFFI} \
      ${YUM_PACKAGE_NCURSES} \
      ${YUM_PACKAGE_OPENSSL} \
      ${YUM_PACKAGE_PIP} \
      ${YUM_PACKAGE_PYTHON} \
      ${YUM_PACKAGE_READLINE} \
      ${YUM_PACKAGE_SQLITE} \
      ${YUM_PACKAGE_WHICH} \
      ${YUM_PACKAGE_YUM_UTILS} \
      ${YUM_PACKAGE_ZLIB} \
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

ARG PUBLISHED_SOURCE_URL
ARG PUBLISHED_DOCUMENTATION_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}
LABEL org.opencontainers.image.description "Tools for deploying applications to Amazon Web Services (AWS)"

WORKDIR /app

# clean up yum cache
RUN rm -rf /var/cache/yum

ENTRYPOINT []
