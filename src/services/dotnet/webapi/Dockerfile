ARG BASE_BUILDER_DOCKER_IMAGE_NAME=mcr.microsoft.com/dotnet/sdk
ARG BASE_DOCKER_IMAGE_NAME=mcr.microsoft.com/dotnet/aspnet
ARG DOTNET_VERSION=6.0
ARG ALPINE_VERSION=3.14

ARG APK_VERSION_CURL=7.79.1-r0

ARG HTTP_PORT=8080
# TODO: https
# read: https://docs.microsoft.com/en-us/aspnet/core/security/docker-https?view=aspnetcore-6.0
# read: https://docs.microsoft.com/en-us/aspnet/core/security/enforcing-ssl?view=aspnetcore-6.0
# ARG HTTPS_PORT=443

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_BUILDER_DOCKER_IMAGE_NAME}:${DOTNET_VERSION}-alpine${ALPINE_VERSION} as builder

WORKDIR /app

COPY ./webapi.csproj /app/

RUN dotnet restore "webapi.csproj"

COPY . /app/

RUN dotnet build -c Release -o /app/build --nologo

RUN dotnet publish -c release -o /app/publish --nologo

FROM ${BASE_DOCKER_IMAGE_NAME}:${DOTNET_VERSION}-alpine${ALPINE_VERSION} as production

ARG APK_VERSION_CURL

ARG PUBLISHED_DOCUMENTATION_URL
ARG PUBLISHED_SOURCE_URL

ARG HTTP_PORT

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}

RUN apk add --no-cache \
      curl=${APK_VERSION_CURL}

COPY --from=builder /app/publish/ /app/

WORKDIR /app

ENV PORT=${HTTP_PORT}
ENV HTTP_PORT=${HTTP_PORT}

EXPOSE ${HTTP_PORT}

# override with: https://docs.docker.com/engine/reference/run/#healthcheck
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s \
  CMD curl --fail "http://localhost:${HTTP_PORT}" || exit 1

ENTRYPOINT ["dotnet", "webapi.dll"]
