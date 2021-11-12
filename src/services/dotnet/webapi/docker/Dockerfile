ARG BASE_BUILDER_DOCKER_IMAGE_NAME=mcr.microsoft.com/dotnet/sdk
ARG BASE_DOCKER_IMAGE_NAME=mcr.microsoft.com/dotnet/aspnet
ARG DOTNET_VERSION=6.0
ARG ALPINE_VERSION=3.14

ARG PUBLISHED_SOURCE_URL=https://github.com/ericis/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://ericis.github.io/hello-cloud/

FROM ${BASE_BUILDER_DOCKER_IMAGE_NAME}:${DOTNET_VERSION}-alpine${ALPINE_VERSION} as builder

WORKDIR /app

COPY . /app/

RUN dotnet build --nologo

RUN dotnet publish -c release -o out --nologo

FROM ${BASE_DOCKER_IMAGE_NAME}:${DOTNET_VERSION}-alpine${ALPINE_VERSION} as production

ARG PUBLISHED_DOCUMENTATION_URL
ARG PUBLISHED_SOURCE_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}

COPY --from=builder /app/out/ /app/

WORKDIR /app

ENTRYPOINT ["dotnet", "webapi.dll"]
