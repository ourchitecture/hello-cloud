# Service: .NET Core

- :octicons-container-16: **Container:** [hello-cloud/our-hello-dotnet-webapi](#docker)
- :octicons-code-16: **Source:** [./src/services/dotnet/webapi/](https://github.com/ourchitecture/hello-cloud/tree/main/src/services/dotnet/webapi)
- :material-dot-net: **Runtime:** [.NET Core](https://dotnet.microsoft.com/) :octicons-link-16:
- :material-language-csharp: **Language:** [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) :octicons-link-16:
- :material-dot-net: **Framework:** [ASP.NET](https://dotnet.microsoft.com/apps/aspnet) :octicons-link-16:

## Getting started

- See "[Docker](#docker)" below to run this project as a container
- The [contributor guide](../contribute.md#executing-tasks) has the steps necessary to run this project locally. :material-more:

## :octicons-infinity-16: DevOps

!!! info ""

    - :material-run-fast: **Tasks:** [`make`](../contribute.md#development)
    - :material-pipe: **Pipeline:** ["./.github/workflows/dotnet_webapi.yml"](https://github.com/ourchitecture/hello-cloud/blob/main/.github/workflows/dotnet_webapi.yml)
    - :octicons-code-16: **Source:** ["./src/services/dotnet/webapi"](https://github.com/ourchitecture/hello-cloud/tree/main/src/services/dotnet/webapi/)
    - :goal: **Deployment(s):** ["hello-cloud/our-hello-dotnet-webapi"](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi) docker container, Amazon Web Services AppRunner, Microsoft Azure App Service, Google Cloud App Engine

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

    Using the standard developer `make` tasks, the service can be containerized and executed with `docker`, `docker-compose` or `podman`. The DevOps pipeline for Continuous Integration (CI) and Deployment (CD) uses the `make deploy` task to build and deploy the service as a container (_`make deploy` only supports "dev_tool=docker" or "dev_tool=podman"_). The GitHub Actions workflow "./.github/workflows/dotnet_webapi.yml" authenticates to the GitHub Container Registry for this repository and pushes (publishes) [the "hello-cloud/our-hello-dotnet-webapi" image](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-dotnet-webapi).

### :cloud: Multi-cloud

!!! example "Commands"

    While each cloud provider below has unique prerequisites and important notes, all of the tasks to deploy to each provider have been abstracted with the following automation tasks. Simply specify the provider as the argument (e.g. `make cloud-init cloud=aws`)

    - Initialize with the command `make cloud-init cloud=aws|azure|gcloud|heroku`
    - Install (deploy) with the command `make cloud-install cloud=aws|azure|gcloud|heroku`
    - Get the applicaiton logs with the command `make cloud-logs cloud=aws|azure|gcloud|heroku`
    - Uninstall (delete/destroy) with the command `make cloud-uninstall cloud=aws|azure|gcloud|heroku`

### :fontawesome-brands-aws: Amazon Web Services (AWS)

!!! todo "Prerequisites"

    See the [contributor guide](../contribute.md#development) for more details.

    - An [AWS account](https://aws.amazon.com/free/) :octicons-link-16: _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: for standard task execution.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16: for containerized task execution.

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`).
    2. Copy the "./deploy/aws/.env.example" file and save it as a new file "./deploy/aws/.env". *This new file will not be committed back to source control as it contains personal and sensitive data.
    3. Edit the file "./deploy/aws/.env" and replace the values according to preferences.
    4. If required, for the values "AWS_ACCESS_KEY_ID" and "AWS_SECRET_ACCESS_KEY", create a new access key by visiting ["Your Security Credentials"](https://console.aws.amazon.com/iam/home#/security_credentials), expanding "Access keys" and creating a new key.
    5. Run the command `make install cloud=aws` to create the AWS Elastic Beanstalk Environment and install the application. This command may take a few minutes.
    6. Update the application with the same command `make install cloud=aws`.
    7. Check the application logs with the command `make logs cloud=aws`
    8. Uninstall and clean up the application deployment with the command `make uninstall cloud=aws`. This command may take several seconds.

!!! todo "Prerequisites"

    See the [contributor guide](../contribute.md#development) for more details.

    - An [Azure account](https://azure.microsoft.com/en-us/free/) :octicons-link-16: _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: for standard task execution.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16: for containerized task execution.

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`)
    2. Copy the "./deploy/azure/.env.example" file and save it as a new file "./deploy/azure/.env". *This new file will not be committed back to source control as it contains personal and sensitive data.
    3. Edit the file "./deploy/azure/.env" and replace the values according to preferences.
    4. If required, for the values "AZURE_SP_APPID", "AZURE_SP_PASSWORD", and "AZURE_SP_TENANT", create new service principal credentials with the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) :octicons-link-16: and the command `az ad sp create-for-rbac --name "our-hello-sp" --role Contributor`, providing any `--name` as desired.
    5. *You may encounter an error with multiple subscriptions as this has not been tested. Consider a [contribution](https://github.com/ourchitecture/hello-cloud/issues/94).
    6. Run the command `make install cloud=azure` to create the Azure Resource Group, Azure AppService Plan, and AppService if they do not exist as well as to deploy the application.
    7. Check the application logs with the command `make logs cloud=azure`
    8. Uninstall and clean up the application deployment with the command `make uninstall cloud=azure`

### :material-google-cloud: Google Cloud

!!! todo "Prerequisites"

      - An [Google Cloud account](https://cloud.google.com/free) _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
      - [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart)
      - Google Cloud [Billing Account](https://console.cloud.google.com/billing)

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

### :fontawesome-brands-salesforce: SalesForce Heroku

!!! todo "Prerequisites"

    - A [Heroku account](https://signup.heroku.com/) _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - [`heroku` CLI](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli)

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/dotnet/webapi`)
    2. Login to your Heroku account with the CLI using the command `heroku login`
    3. Run the command `make heroku-init` to create and configure the cloud app including assigning the [community monorepo buildpack](https://github.com/lstoll/heroku-buildpack-monorepo#readme) as well as a community [dotnet buildpack](https://github.com/jincod/dotnetcore-buildpack)
    4. Install the application with the command `make heroku-install`
    5. Check the application logs with the command `make heroku-logs`
    6. Uninstall and clean up the application deployment with the command `make heroku-uninstall`

## Roadmap

???+ info "Started"

    [Start contributing!](../contribute.md){ .md-button }

???+ question "Future"

    - Deploy to cloud Managed Containers (_refers to a "run as container" deployment over full-blown Managed Kubernetes deployment_)
        - "azure"
        - "heroku"
    - Deploy to cloud Managed Kubernetes
        - "aws"
        - "azure"
        - "gcloud"
        - "heroku"
    - HTTPS only deployment
    - GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
    - Service contracts and auto-generated documentation integrated with MkDocs documentation site
    - Ping / Health endpoint

???+ success "Completed"

    - Local "hello-cloud" service (`dotnet`)
    - Build and run as container (`docker`, `docker-compose`, or `podman`)
    - Deploy container to GitHub Container Registry as GitHub Package
    - GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
    - Deploy to cloud Platform-as-a-Service (PaaS)
        - :material-heart-broken: "aws" requires a container
        - "azure"
        - :material-heart-broken: "gcloud" requires a container
        - "heroku"
    - Deploy to cloud Managed Containers (_refers to a "run as container" deployment over full-blown Managed Kubernetes deployment_)
        - "aws"
        - "gcloud"
