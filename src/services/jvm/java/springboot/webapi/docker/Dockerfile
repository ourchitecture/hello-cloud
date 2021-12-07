ARG BASE_DOCKER_IMAGE_NAME=docker.io/library/openjdk
ARG JAVA_VERSION=17

ARG GRADLE_VERSION=7.2

ARG HTTP_PORT=8080

# the following directory and file get set the first time
# gradle is run and hides the "welcome" message from appearing
ARG GRADLE_NOTIFICATIONS_PATH=/root/.gradle/notifications/${GRADLE_VERSION}
ARG GRADLE_NOTIFICATIONS_WELCOME_FILE=${GRADLE_NOTIFICATIONS_PATH}/release-features.rendered

ARG JAR_NAME=hello-cloud
ARG JAR_VERSION=0.0.1-SNAPSHOT
ARG JAR_FILE_NAME=${JAR_NAME}-${JAR_VERSION}.jar

ARG PUBLISHED_SOURCE_URL=https://github.com/ourchitecture/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://www.ourchitecture.io/hello-cloud/

FROM ${BASE_DOCKER_IMAGE_NAME}:${JAVA_VERSION} as base

################################################################################
# download gradle tooling and cache as docker layer
# this layer will not be triggered unless there is
# a change to the gradle wrapper files
################################################################################
FROM base as gradle

ARG GRADLE_VERSION
ARG GRADLE_NOTIFICATIONS_PATH
ARG GRADLE_NOTIFICATIONS_WELCOME_FILE

# install "xargs" for gradle
# TODO: findutils version
RUN microdnf install findutils

WORKDIR /app

COPY ./gradlew /app/
COPY ./gradle/ /app/gradle/

# execute a gradle command to force initial download
# create a feature flag file to hide the "welcome" message
RUN chmod +x ./gradlew \
  && mkdir -p ${GRADLE_NOTIFICATIONS_PATH} \
  && touch ${GRADLE_NOTIFICATIONS_WELCOME_FILE} \
  && ./gradlew \
    --version \
    --quiet \
    --console=plain \
    --no-daemon

################################################################################
# build the java jar file
################################################################################
FROM gradle as builder

ARG JAR_FILE_NAME

WORKDIR /app

COPY . /app/

RUN chmod +x ./gradlew \
  && ./gradlew build \
    --console=plain \
    --no-daemon \
  && cp /app/build/libs/${JAR_FILE_NAME} ./app.jar

################################################################################
# run the java jar file
################################################################################
FROM base as production

ARG PUBLISHED_DOCUMENTATION_URL
ARG PUBLISHED_SOURCE_URL

ARG HTTP_PORT

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}

# TODO: curl version
RUN microdnf install curl

COPY --from=builder /app/app.jar /app/

WORKDIR /app

ENV HTTP_PORT=${HTTP_PORT}

EXPOSE ${HTTP_PORT}

# override with: https://docs.docker.com/engine/reference/run/#healthcheck
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s \
  CMD curl --silent --fail "http://localhost:${HTTP_PORT}" || exit 1

ENTRYPOINT [ "java", "-jar", "./app.jar" ]
