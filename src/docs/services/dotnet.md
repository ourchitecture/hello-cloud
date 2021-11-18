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

### Multi-cloud

While each cloud provider below has unique prerequisites and important notes, all of the tasks to deploy to each provider have been abstracted with the following automation tasks. Simply specify the provider as the argument (e.g. `make cloud-init cloud=aws`)

- Initialize with the command `make cloud-init cloud=aws|gcloud`
- Install (deploy) with the command `make cloud-install cloud=aws|gcloud`
- Get the applicaiton logs with the command `make cloud-logs cloud=aws|gcloud`
- Uninstall (delete/destroy) with the command `make cloud-uninstall cloud=aws|gcloud`

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

### Google Cloud

#### Prerequisites

- An [Google Cloud account](https://cloud.google.com/free) _\*this project worked with free infrastructure at the time of its creation_
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart)
- Google Cloud [Billing Account](https://console.cloud.google.com/billing)

#### Steps to deploy

Every attempt is made to automate the deployment. However, some timing issues have been observed as well as having to manually enable "Code Build" and manually associating dynamically created projects with a billing account. [Contributions are welcome!](../contribute.md)

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`).
2. Login to your Google Cloud account with the CLI using the command `gcloud auth login`.
3. Run the command `make gcloud-init gcloud_project_name_suffix=001` to create the Google Cloud project.
4. If the output indicates that billing must be enabled, login to the [projects list](https://console.cloud.google.com/billing/projects) and associate the newly created project with the appropriate billing account (even if you are using free resources). Once the project is associated with a billing account, re-run the "gcloud-init" command above.
5. Install the application with the command `make gcloud-install`.
6. Check the application logs with the command `make gcloud-logs`.
7. Uninstall and clean up the application deployment with the command `make gcloud-uninstall gcloud_project_name_suffix=001`.

_\*Update the "gcloud_project_name_suffix" argument value for `gcloud-init` and `gcloud-uninstall` by incrementing the number to ensure a unique project name, or specify a custom unique name by using the argument "gcloud_project_unique_name" instead. By default, Google Cloud retains deleted projects for several days, so it is not possible to recreate the same project multiple times within a short period. A future [contribution to this project](../contribute.md) could simply restore a deleted project if it was recently deleted and use the same name._

## Roadmap

- ✅ Local "hello-cloud" service (`dotnet`)
- ✅ Build and run as container (`docker`, `docker-compose`, or `podman`)
- ✅ Deploy container to GitHub Container Registry as GitHub Package
- ✅ GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
- ⬜ Deploy to cloud Platform-as-a-Service (PaaS) ("aws", "gcloud", "azure", "heroku")
- ✅ Deploy to cloud Managed Containers ("aws", "gcloud") _\*prefer "run as container" deployment over full-blown Managed Kubernetes deployment_
- ⬜ Deploy to cloud Managed Containers ("azure", "heroku") _\*prefer "run as container" deployment over full-blown Managed Kubernetes deployment_
- ⬜ GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
- ⬜ Service contracts and auto-generated documentation integrated with MkDocs documentation site
- ⬜ Ping / Health endpoint
