# Service: Java with SpringBoot

- **Path:** [./src/java/springboot/webapi/](https://github.com/ericis/hello-cloud/tree/main/src/java/springboot/webapi)
- **Runtime:** [OpenJDK](https://openjdk.java.net/) 🔗
- **Language:** [Java](https://docs.oracle.com/javase/specs/) 🔗
- **Framework:** [SpringBoot](https://spring.io/projects/spring-boot) 🔗

## Getting started

The [contributor guide](../contribute.md) has the steps necessary to run this project locally.

Run this service with any Open Container Initiative (OCI) compatible runtime, like `docker` or `podman` (e.g.
`docker run --name=our-hello-java-springboot-webapi --detach --publish=8080:8080 ghcr.io/ericis/hello-world/our-hello-java-springboot-webapi:latest` and then browse to http://localhost:8080/).

## DevOps

- **Tasks:** [`make`](../contribute.md)
- **Pipeline:** ["./.github/workflows/java_springboot_webapi.yml"](https://github.com/ericis/hello-cloud/blob/main/.github/workflows/java_springboot_webapi.yml)
- **Source:** ["./src/java/springboot/webapi"](https://github.com/ericis/hello-cloud/tree/main/src/java/springboot/webapi/)
- **Deployment(s):** ["hello-world/our-hello-java-springboot-webapi"](https://github.com/ericis/hello-cloud/pkgs/container/hello-world%2Four-hello-java-springboot-webapi) docker container

## Deployments

### Docker

The ["hello-world/our-hello-java-springboot-webapi"](https://github.com/ericis/hello-cloud/pkgs/container/hello-world%2Four-hello-java-springboot-webapi) docker image is simply the packaged and runnable version of the web service.

Using the standard developer `make` tasks, the service can be containerized and executed with `docker`, `docker-compose` or `podman`. The DevOps pipeline for Continuous Integration (CI) and Deployment (CD) uses the `make deploy` task to build and deploy the service as a container (_`make deploy` only supports "dev_tool=docker" or "dev_tool=podman"_). The GitHub Actions workflow "./.github/workflows/java_springboot_webapi.yml" authenticates to the GitHub Container Registry for this repository and pushes (publishes) [the "hello-world/our-hello-java-springboot-webapi" image](https://github.com/ericis/hello-cloud/pkgs/container/hello-world%2Four-hello-java-springboot-webapi).

## Roadmap

- ✅ Local "hello-world" service (`yarn` or `npm`)
- ✅ Build and run as container (`docker`, `docker-compose`, or `podman`)
- ✅ Deploy container to GitHub Container Registry as GitHub Package
- ✅ GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
- ⬜ Deploy to cloud Platform-as-a-Service (PaaS) ("aws", "azure", "gcloud", "heroku")
- ⬜ Deploy to cloud Managed Containers ("aws", "azure", "gcloud", "heroku") _\*prefer "run as container" deployment over full-blown Managed Kubernetes deployment_
- ⬜ GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
- ⬜ Service contracts and auto-generated documentation integrated with MkDocs documentation site
- ⬜ Ping / Health endpoint
