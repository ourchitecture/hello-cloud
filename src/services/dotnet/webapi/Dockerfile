ARG BASE_BUILDER_DOCKER_IMAGE_NAME=mcr.microsoft.com/dotnet/sdk
ARG BASE_DOCKER_IMAGE_NAME=mcr.microsoft.com/dotnet/aspnet
ARG DOTNET_VERSION=6.0
ARG ALPINE_VERSION=3.14

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_BUILDER_DOCKER_IMAGE_NAME}:${DOTNET_VERSION}-alpine${ALPINE_VERSION} as builder

WORKDIR /app

COPY ["webapi.csproj", ""]

RUN dotnet restore "webapi.csproj"

COPY . /app/

RUN dotnet build -c Release -o /app/build --nologo

RUN dotnet publish -c release -o /app/publish --nologo

FROM ${BASE_DOCKER_IMAGE_NAME}:${DOTNET_VERSION}-alpine${ALPINE_VERSION} as production

ARG PUBLISHED_DOCUMENTATION_URL
ARG PUBLISHED_SOURCE_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}

COPY --from=builder /app/publish/ /app/

WORKDIR /app

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "webapi.dll"]
