# Service: .NET Core

- **Path:** [./src/services/dotnet/webapi/](https://github.com/ericis/hello-cloud/tree/main/src/services/dotnet/webapi)
- **Runtime:** [.NET Core](https://dotnet.microsoft.com/) 🔗
- **Language:** [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) 🔗
- **Framework:** [ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 🔗

## Getting started

The [contributor guide](../contribute.md) has the steps necessary to run this project locally.

Run this service with any Open Container Initiative (OCI) compatible runtime, like `docker` or `podman` (e.g.
`docker run --name=our-hello-dotnet-webapi --detach --publish=5124:80 ghcr.io/ericis/hello-cloud/our-hello-dotnet-webapi:latest` and then browse to http://localhost:5124/).

## DevOps

- **Tasks:** [`make`](../contribute.md)
- **Pipeline:** ["./.github/workflows/dotnet_webapi.yml"](https://github.com/ericis/hello-cloud/blob/main/.github/workflows/dotnet_webapi.yml)
- **Source:** ["./src/services/dotnet/webapi"](https://github.com/ericis/hello-cloud/tree/main/src/services/dotnet/webapi/)
- **Deployment(s):** ["hello-cloud/our-hello-dotnet-webapi"](https://github.com/ericis/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi) docker container

## Deployments

### Docker

The ["hello-cloud/our-hello-dotnet-webapi"](https://github.com/ericis/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi) docker image is simply the packaged and runnable version of the web service.

Using the standard developer `make` tasks, the service can be containerized and executed with `docker`, `docker-compose` or `podman`. The DevOps pipeline for Continuous Integration (CI) and Deployment (CD) uses the `make deploy` task to build and deploy the service as a container (_`make deploy` only supports "dev_tool=docker" or "dev_tool=podman"_). The GitHub Actions workflow "./.github/workflows/java_springboot_webapi.yml" authenticates to the GitHub Container Registry for this repository and pushes (publishes) [the "hello-cloud/our-hello-dotnet-webapi" image](https://github.com/ericis/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi).

### Amazon Web Services (AWS)

#### Prerequisites

- An [AWS account](https://aws.amazon.com/free/) 🔗 (_this project worked with free infrastructure at the time of its creation_)
- [`aws` CLI](https://docs.aws.amazon.com/cli/) 🔗
- `dotnet` ["aws.deploy.cli" tool](https://github.com/aws/aws-dotnet-deploy#getting-started)

#### Steps to deploy

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`).
2. Run the command `make aws-init` to verify your tool installations.
3. Install the application with the command `make aws-install`. This command may take several seconds.
4. Check the application logs with the command `make aws-logs`. [Help wanted](../contribute.md) to automate this command.
5. Uninstall and clean up the application deployment with the command `make aws-uninstall`. This command may take several seconds.

## Roadmap

- ✅ Local "hello-cloud" service (`dotnet`)
- ✅ Build and run as container (`docker`, `docker-compose`, or `podman`)
- ✅ Deploy container to GitHub Container Registry as GitHub Package
- ✅ GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
- ✅ Deploy to cloud Platform-as-a-Service (PaaS) ("aws")
- ⬜ Deploy to cloud Platform-as-a-Service (PaaS) ("azure", "gcloud", "heroku")
- ⬜ Deploy to cloud Managed Containers ("aws", "azure", "gcloud", "heroku") _\*prefer "run as container" deployment over full-blown Managed Kubernetes deployment_
- ⬜ GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
- ⬜ Service contracts and auto-generated documentation integrated with MkDocs documentation site
- ⬜ Ping / Health endpoint
