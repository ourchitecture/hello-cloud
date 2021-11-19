# Service: .NET Core

-   :octicons-container-16: **Container:** [hello-cloud/our-hello-dotnet-webapi](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi)
-   :octicons-code-16: **Source:** [./src/services/dotnet/webapi/](https://github.com/ourchitecture/hello-cloud/tree/main/src/services/dotnet/webapi)
-   :material-dot-net: **Runtime:** [.NET Core](https://dotnet.microsoft.com/) :octicons-link-16:
-   :material-language-csharp: **Language:** [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) :octicons-link-16:
-   :material-dot-net: **Framework:** [ASP.NET](https://dotnet.microsoft.com/apps/aspnet) :octicons-link-16:

## Getting started

-   See "[Docker](#docker)" below to run this project as a container
-   The [contributor guide](../contribute.md#executing-tasks) has the steps necessary to run this project locally. :material-more:

## :octicons-infinity-16: DevOps

!!! info ""

    -   :material-run-fast: **Tasks:** [`make`](../contribute.md#development)
    -   :material-pipe: **Pipeline:** ["./.github/workflows/dotnet_webapi.yml"](https://github.com/ourchitecture/hello-cloud/blob/main/.github/workflows/dotnet_webapi.yml)
    -   :octicons-code-16: **Source:** ["./src/services/dotnet/webapi"](https://github.com/ourchitecture/hello-cloud/tree/main/src/services/dotnet/webapi/)
    -   :goal: **Deployment(s):** ["hello-cloud/our-hello-dotnet-webapi"](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi) docker container, Amazon Web Services AppRunner, Microsoft Azure App Service, Google Cloud App Engine

## Deployments

### :material-docker: Docker

!!! example "Run as a container"

    The ["hello-cloud/our-hello-dotnet-webapi"](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi) docker image is simply the packaged and runnable version of the web service.

    Run this service with any Open Container Initiative (OCI) compatible runtime, like `docker` or `podman` and then browse to http://localhost:5124/.

    ```shell
    docker run \
      --name=our-hello-dotnet-webapi \
      --detach \
      --publish=5124:80 \
      ghcr.io/ourchitecture/hello-cloud/our-hello-dotnet-webapi:latest
    ```

    Using the standard developer `make` tasks, the service can be containerized and executed with `docker`, `docker-compose` or `podman`. The DevOps pipeline for Continuous Integration (CI) and Deployment (CD) uses the `make deploy` task to build and deploy the service as a container (_`make deploy` only supports "dev_tool=docker" or "dev_tool=podman"_). The GitHub Actions workflow "./.github/workflows/java_springboot_webapi.yml" authenticates to the GitHub Container Registry for this repository and pushes (publishes) [the "hello-cloud/our-hello-dotnet-webapi" image](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi).

### :cloud: Multi-cloud

!!! example "Commands"

    While each cloud provider below has unique prerequisites and important notes, all of the tasks to deploy to each provider have been abstracted with the following automation tasks. Simply specify the provider as the argument (e.g. `make cloud-init cloud=aws`)

    -   Initialize with the command `make cloud-init cloud=aws|gcloud`
    -   Install (deploy) with the command `make cloud-install cloud=aws|gcloud`
    -   Get the applicaiton logs with the command `make cloud-logs cloud=aws|gcloud`
    -   Uninstall (delete/destroy) with the command `make cloud-uninstall cloud=aws|gcloud`

### :fontawesome-brands-aws: Amazon Web Services (AWS)

!!! todo "Prerequisites"

    -   An [AWS account](https://aws.amazon.com/free/) :octicons-link-16: (_this project worked with free infrastructure at the time of its creation_)
    -   [`aws` CLI](https://docs.aws.amazon.com/cli/) :octicons-link-16:
    -   `dotnet` ["aws.deploy.cli" tool](https://github.com/aws/aws-dotnet-deploy#getting-started)

!!! example "Commands"

      1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`).
      2. Run the command `make aws-init` to verify your tool installations.
      3. Install the application with the command `make aws-install`. This command may take several seconds.
      4. Check the application logs with the command `make aws-logs`. [Help wanted](../contribute.md) to automate this command.
      5. Uninstall and clean up the application deployment with the command `make aws-uninstall`. This command may take several seconds.

### :material-microsoft-azure: Microsoft Azure

!!! todo "Prerequisites"

      -   An [Azure account](https://azure.microsoft.com/en-us/free/) :octicons-link-16: (_this project worked with free infrastructure at the time of its creation_)
      -   [`az` CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) :octicons-link-16:
      -   [`dotnet` 6 SDK](https://dotnet.microsoft.com/download) :octicons-link-16:

!!! example "Commands"

      1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`)
      2. Login to your Azure account with the CLI using the command `az login`
      3. If you have more than one subscription, first [set the default subscription](https://docs.microsoft.com/en-us/azure/developer/javascript/tutorial/tutorial-vscode-azure-cli-node/tutorial-vscode-azure-cli-node-03#set-your-default-subscription)
      4. Run the command `make azure-init` to create the Azure Resource Group
      5. Install the application with the command `make azure-install`
      6. Check the application logs with the command `make azure-logs`
      7. Uninstall and clean up the application deployment with the command `make azure-uninstall`

### :material-google-cloud: Google Cloud

!!! todo "Prerequisites"

      -   An [Google Cloud account](https://cloud.google.com/free) _\*this project worked with free infrastructure at the time of its creation_
      -   [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart)
      -   Google Cloud [Billing Account](https://console.cloud.google.com/billing)

!!! attention "Known issues"

      Every attempt has been made to automate the deployment. However, some timing issues have been observed as well as having to manually enable "Code Build" and manually associating dynamically created projects with a billing account. [Contributions are welcome!](../contribute.md)

!!! example "Commands"

      1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`).
      2. Login to your Google Cloud account with the CLI using the command `gcloud auth login`.
      3. Run the command `make gcloud-init gcloud_project_name_suffix=001` to create the Google Cloud project.
      4. If the output indicates that billing must be enabled, login to the [projects list](https://console.cloud.google.com/billing/projects) and associate the newly created project with the appropriate billing account (even if you are using free resources). Once the project is associated with a billing account, re-run the "gcloud-init" command above.
      5. Install the application with the command `make gcloud-install`.
      6. Check the application logs with the command `make gcloud-logs`.
      7. Uninstall and clean up the application deployment with the command `make gcloud-uninstall gcloud_project_name_suffix=001`.

!!! tip "Tip: Project Naming"

      Update the "gcloud_project_name_suffix" argument value for `gcloud-init` and `gcloud-uninstall` by incrementing the number to ensure a unique project name, or specify a custom unique name by using the argument "gcloud_project_unique_name" instead. By default, Google Cloud retains deleted projects for several days, so it is not possible to recreate the same project multiple times within a short period. A future [contribution to this project](../contribute.md) could simply restore a deleted project if it was recently deleted and use the same name.

## Roadmap

???+ info "Started"

    [Start contributing!](../contribute.md){ .md-button }

???+ question "Future"

    -   Deploy to cloud Platform-as-a-Service (PaaS)
        -   "heroku"
    -   Deploy to cloud Managed Containers (_refers to a "run as container" deployment over full-blown Managed Kubernetes deployment_)
        -   "azure"
        -   "heroku"
    -   Deploy to cloud Managed Kubernetes
        -   "aws"
        -   "azure"
        -   "gcloud"
        -   "heroku"
    -   GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
    -   Service contracts and auto-generated documentation integrated with MkDocs documentation site
    -   Ping / Health endpoint

???+ success "Completed"

    -   Local "hello-cloud" service (`dotnet`)
    -   Build and run as container (`docker`, `docker-compose`, or `podman`)
    -   Deploy container to GitHub Container Registry as GitHub Package
    -   GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
    -   Deploy to cloud Platform-as-a-Service (PaaS)
        -   :material-heart-broken: "aws" requires a container
        -   "azure"
        -   :material-heart-broken: "gcloud" requires a container
    -   Deploy to cloud Managed Containers (_refers to a "run as container" deployment over full-blown Managed Kubernetes deployment_)
        -   "aws"
        -   "gcloud"
