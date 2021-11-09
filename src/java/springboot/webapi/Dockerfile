ARG BASE_DOCKER_IMAGE_NAME=docker.io/library/openjdk
ARG JAVA_VERSION=17

ARG JAR_NAME=hello-cloud
ARG JAR_VERSION=0.0.1-SNAPSHOT
ARG JAR_FILE_NAME=${JAR_NAME}-${JAR_VERSION}.jar

ARG PUBLISHED_SOURCE_URL=https://github.com/ericis/hello-cloud
ARG PUBLISHED_DOCUMENTATION_URL=https://ericis.github.io/hello-cloud/

FROM ${BASE_DOCKER_IMAGE_NAME}:${JAVA_VERSION} as base

################################################################################
# download gradle tooling and cache as docker layer
# this layer will not be triggered unless there is
# a change to the gradle wrapper files
################################################################################
FROM base as gradle

WORKDIR /app

COPY ./gradlew /app/
COPY ./gradle/ /app/gradle/

# download the gradle tooling
RUN chmod +x ./gradlew \
  && ./gradlew --version

################################################################################
# build the java jar file
################################################################################
FROM gradle as builder

ARG JAR_FILE_NAME

WORKDIR /app

COPY . /app/

RUN chmod +x ./gradlew \
  && ./gradlew build \
  && cp /app/build/libs/${JAR_FILE_NAME} ./app.jar

################################################################################
# run the java jar file
################################################################################
FROM base as production

ARG PUBLISHED_DOCUMENTATION_URL
ARG PUBLISHED_SOURCE_URL

LABEL org.opencontainers.image.documentation ${PUBLISHED_DOCUMENTATION_URL}
LABEL org.opencontainers.image.source ${PUBLISHED_SOURCE_URL}

COPY --from=builder /app/app.jar /app/

WORKDIR /app

ENTRYPOINT [ "java", "-jar", "./app.jar" ]
