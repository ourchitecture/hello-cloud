ARG BASE_DOCKER_IMAGE_NAME="ghcr.io/ourchitecture/hello-cloud/our-hello-tasks-aws-cli"

ARG AWS_CLI_VERSION="2.4.7"

ARG EB_CLI_VERSION="3.20.2"

ARG YUM_ARCH="x86_64"

ARG DOTNET_RPM_URL="https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm"
ARG DOTNET_VERSION="6.0"
ARG YUM_PACKAGE_DOTNET_SDK="dotnet-sdk-${DOTNET_VERSION}-6.0.101-1.${YUM_ARCH}"

ARG DOTNET_AWS_DEPLOY_CLI_VERSION="0.31.11"

ARG NVM_VERSION="v0.39.1"
ARG NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh"

ARG YUM_PACKAGE_DOCKER="docker"

ARG DOCKER_REPO_URL="https://download.docker.com/linux/centos/docker-ce.repo"

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_DOCKER_IMAGE_NAME}:${AWS_CLI_VERSION}-eb${EB_CLI_VERSION} as base

FROM base as dotnet

ARG DOTNET_RPM_URL
ARG YUM_PACKAGE_DOTNET_SDK
ARG DOTNET_VERSION

# https://aka.ms/dotnet-cli-telemetry
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

# BUG: yum simply skips over missing packages without an error
#       https://serverfault.com/a/694959
# https://docs.microsoft.com/en-us/dotnet/core/install/linux-centos#centos-7-
RUN yum update \
    && rpm -Uvh ${DOTNET_RPM_URL} \
    && yum info ${YUM_PACKAGE_DOTNET_SDK} >> /dev/null 2>&1 || exit \
    && yum --assumeyes install \
      ${YUM_PACKAGE_DOTNET_SDK} \
    && yum -y clean all \
    && rm -rf /var/cache \
    && dotnet --version

FROM dotnet as dotnet_aws_deploy

ARG DOTNET_AWS_DEPLOY_CLI_VERSION

# https://github.com/aws/aws-dotnet-deploy#getting-started
RUN dotnet tool install \
      AWS.Deploy.CLI \
      --version ${DOTNET_AWS_DEPLOY_CLI_VERSION} \
      --tool-path /usr/local/sbin

# INFO: `dotnet aws deploy` requires node
FROM dotnet_aws_deploy as node

ARG NVM_VERSION
ARG NVM_INSTALL_URL

# https://github.com/nvm-sh/nvm
RUN curl -o- ${NVM_INSTALL_URL} | bash \
    && echo ". /root/.nvm/nvm.sh" > /root/.bashrc \
    && . /root/.nvm/nvm.sh \
    && nvm install --lts \
    && nvm use --lts

# INFO: `dotnet aws deploy` requires docker
FROM node as docker

ARG DOCKER_REPO_URL
ARG YUM_PACKAGE_DOCKER

ENV container=docker

# BUG: yum simply skips over missing packages without an error
#       https://serverfault.com/a/694959
# https://gist.github.com/npearce/6f3c7826c7499587f00957fee62f8ee9
RUN amazon-linux-extras install docker -y

COPY ./our-docker-init.sh /usr/bin/our-docker-init

RUN chmod +x /usr/bin/our-docker-init

ENTRYPOINT ["/usr/bin/our-docker-init"]

FROM docker as production

ARG PUBLISHED_SOURCE_URL
ARG PUBLISHED_DOCUMENTATION_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}
LABEL org.opencontainers.image.description "Tools for deploying .NET Core applications to Amazon Web Services (AWS)"

WORKDIR /app

# clean up yum cache
RUN rm -rf /var/cache/yum
