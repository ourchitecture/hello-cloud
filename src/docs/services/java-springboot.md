# Service: Java with SpringBoot

- **Path:** [./src/java/springboot/webapi/](https://github.com/ericis/hello-cloud/tree/main/src/java/springboot/webapi)
- **Runtime:** [OpenJDK](https://openjdk.java.net/) 🔗
- **Language:** [Java](https://docs.oracle.com/javase/specs/) 🔗
- **Framework:** [SpringBoot](https://spring.io/projects/spring-boot) 🔗

## Getting started

The [contributor guide](../contribute.md) has the steps necessary to run this project locally.

Run this service with any Open Container Initiative (OCI) compatible runtime, like `docker` or `podman` (e.g.
`docker run --name=our-hello-java-springboot-webapi --detach --publish=8080:8080 ghcr.io/ericis/hello-cloud/our-hello-java-springboot-webapi:latest` and then browse to http://localhost:8080/).

## DevOps

- **Tasks:** [`make`](../contribute.md)
- **Pipeline:** ["./.github/workflows/java_springboot_webapi.yml"](https://github.com/ericis/hello-cloud/blob/main/.github/workflows/java_springboot_webapi.yml)
- **Source:** ["./src/java/springboot/webapi"](https://github.com/ericis/hello-cloud/tree/main/src/java/springboot/webapi/)
- **Deployment(s):** ["hello-cloud/our-hello-java-springboot-webapi"](https://github.com/ericis/hello-cloud/pkgs/container/hello-cloud%2Four-hello-java-springboot-webapi) docker container

## Deployments

### Docker

The ["hello-cloud/our-hello-java-springboot-webapi"](https://github.com/ericis/hello-cloud/pkgs/container/hello-cloud%2Four-hello-java-springboot-webapi) docker image is simply the packaged and runnable version of the web service.

Using the standard developer `make` tasks, the service can be containerized and executed with `docker`, `docker-compose` or `podman`. The DevOps pipeline for Continuous Integration (CI) and Deployment (CD) uses the `make deploy` task to build and deploy the service as a container (_`make deploy` only supports "dev_tool=docker" or "dev_tool=podman"_). The GitHub Actions workflow "./.github/workflows/java_springboot_webapi.yml" authenticates to the GitHub Container Registry for this repository and pushes (publishes) [the "hello-cloud/our-hello-java-springboot-webapi" image](https://github.com/ericis/hello-cloud/pkgs/container/hello-cloud%2Four-hello-java-springboot-webapi).

### Multi-cloud

While each cloud provider below has unique prerequisites and important notes, all of the tasks to deploy to each provider have been abstracted with the following automation tasks. Simply specify the provider as the argument (e.g. `make cloud-init cloud=aws`)

- Initialize with the command `make cloud-init cloud=aws|azure]`
- Install (deploy) with the command `make cloud-install cloud=aws|azure`
- Get the applicaiton logs with the command `make cloud-logs cloud=aws|azure`
- Uninstall (delete/destroy) with the command `make cloud-uninstall cloud=aws|azure`

### Amazon Web Services (AWS)

#### Prerequisites

- An [AWS account](https://aws.amazon.com/free/) 🔗 (_this project worked with free infrastructure at the time of its creation_)
- [`eb` CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html) 🔗

#### Steps to deploy

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/java/springboot/webapi`)
2. Run the command `make aws-init` to create the AWS Elastic Beanstalk Environment. This command may take a few minutes. The `eb` CLI will prompt you for access credentials. Create a new access key by visiting ["Your Security Credentials"](https://console.aws.amazon.com/iam/home#/security_credentials) 🔗, expanding "Access keys" and creating a new key.
3. Install the application with the command `make aws-install`. This command may take several seconds.
4. Check the application logs with the command `make aws-logs`
5. Uninstall and clean up the application deployment with the command `make aws-uninstall`. This command may take several seconds.

### Microsoft Azure

#### Prerequisites

- An [Azure account](https://azure.microsoft.com/en-us/free/) 🔗 (_this project worked with free infrastructure at the time of its creation_)
- [`az` CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) 🔗
- [`java` 11 OpenJDK](https://openjdk.java.net/install/) 🔗 (required to execute `./mvnw` commands)

#### Steps to deploy

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/java/springboot/webapi`)
2. Login to your Azure account with the CLI using the command `az login`
3. If you have more than one subscription, first [set the default subscription](https://docs.microsoft.com/en-us/azure/developer/javascript/tutorial/tutorial-vscode-azure-cli-node/tutorial-vscode-azure-cli-node-03#set-your-default-subscription)
4. Run the command `make azure-init` to create the Azure Resource Group
5. Install the application with the command `make azure-install dev_tool=maven`. It doesn't appear that a gradle-compatible solution is available. [Failed attempts have been made](https://github.com/Azure/azure-cli/issues/20277) to deploy the ".jar" file independently of `./gradlew` or `./mvnw` using the Azure CLI e.g. `az webapp deploy ...`. A future contribution could at least dockerize the maven command, so that tools like `docker` and `podman` could be used.)
6. Check the application logs with the command `make azure-logs`
7. Uninstall and clean up the application deployment with the command `make azure-uninstall`

## Roadmap

- ✅ Local "hello-cloud" service (`./gradlew` or `./mvnw`)
- ✅ Build and run as container (`docker`, `docker-compose`, or `podman`)
- ✅ Deploy container to GitHub Container Registry as GitHub Package
- ✅ GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
- ✅ Deploy to cloud Platform-as-a-Service (PaaS) ("aws", "azure")
- ⬜ Deploy to cloud Platform-as-a-Service (PaaS) ("gcloud", "heroku")
- ⬜ Deploy to cloud Managed Containers ("aws", "azure", "gcloud", "heroku") _\*prefer "run as container" deployment over full-blown Managed Kubernetes deployment_
- ⬜ GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
- ⬜ Service contracts and auto-generated documentation integrated with MkDocs documentation site
- ⬜ Ping / Health endpoint
