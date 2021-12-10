# Service: NodeJS with ExpressJS

- :octicons-container-16: **Container:** ["hello-cloud/our-hello-nodejs-expressjs-webapi"](#docker)
- :octicons-code-16: **Source:** [./src/services/nodejs/expressjs/webapi/](https://github.com/ourchitecture/hello-cloud/tree/main/src/services/nodejs/expressjs/webapi)
- :fontawesome-brands-node: **Runtime:** [NodeJS](https://nodejs.org/) :octicons-link-16:
- :material-language-javascript: **Language:** [JavaScript](https://javascript.info/) :octicons-link-16:
- :fontawesome-brands-node-js: **Framework:** [ExpressJS](https://expressjs.com/) :octicons-link-16:

## Getting started

- See "[Docker](#docker)" below to run this project as a container
- The [contributor guide](../contribute.md#executing-tasks) has the steps necessary to run this project locally. :material-more:

## :octicons-infinity-16: DevOps

!!! info ""

    - :material-run-fast: **Tasks:** [`make`](../contribute.md#development)
    - :material-pipe: **Pipeline:** ["./.github/workflows/nodejs_expressjs_webapi.yml"](https://github.com/ourchitecture/hello-cloud/blob/main/.github/workflows/nodejs_expressjs_webapi.yml)
    - :octicons-code-16: **Source:** ["./src/services/nodejs/expressjs/webapi"](https://github.com/ourchitecture/hello-cloud/tree/main/src/services/nodejs/expressjs/webapi/)
    - :goal: **Deployment(s):** ["hello-cloud/our-hello-nodejs-expressjs-webapi"](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-nodejs-expressjs-webapi) docker container, Amazon Web Services Elastic Beanstalk, Microsoft Azure App Service, Google Cloud App Engine, Salesforce Heroku

## Deployments

### :material-docker: Docker

!!! example "Run as a container"

    The ["hello-cloud/our-hello-nodejs-expressjs-webapi"](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-nodejs-expressjs-webapi) docker image is simply the packaged and runnable version of the web service.

    Run this service with any Open Container Initiative (OCI) compatible runtime, like `docker` or `podman` and then browse to http://localhost:3000/.

    ```shell
    docker run \
      --name=our-hello-nodejs-expressjs-webapi \
      --detach \
      --publish=3000:3000 \
      ghcr.io/ourchitecture/hello-cloud/our-hello-nodejs-expressjs-webapi:latest
    ```

    Using the standard developer `make` tasks, the service can be containerized and executed with `docker`, `docker-compose` or `podman`. The DevOps pipeline for Continuous Integration (CI) and Deployment (CD) uses the `make deploy` task to build and deploy the service as a container (_`make deploy` only supports "dev_tool=docker" or "dev_tool=podman"_). The GitHub Actions workflow "./.github/workflows/java_springboot_webapi.yml" authenticates to the GitHub Container Registry for this repository and pushes (publishes) [the "hello-cloud/our-hello-nodejs-expressjs-webapi" image](https://github.com/ourchitecture/hello-cloud/pkgs/container/hello-cloud%2Four-hello-nodejs-expressjs-webapi).

### :cloud: Multi-cloud

!!! example "Commands"

    While each cloud provider below has unique prerequisites and important notes, all of the tasks to deploy to each provider have been abstracted with the following automation tasks. Simply specify the provider as the argument (e.g. `make install cloud=aws`)

    - Initialize and install (deploy) with the command `make install cloud=aws|azure|gcloud|heroku`
    - Get the applicaiton logs with the command `make logs cloud=aws|azure|gcloud|heroku`
    - Uninstall (delete/destroy) with the command `make uninstall cloud=aws|azure|gcloud|heroku`

### :fontawesome-brands-aws: Amazon Web Services (AWS)

!!! todo "Prerequisites"

    See the [contributor guide](../contribute.md#development) for more details.

    - An [AWS account](https://aws.amazon.com/free/) :octicons-link-16: _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: for standard task execution.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16: for containerized task execution.

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/nodejs/expressjs/webapi`)
    2. Copy the "./deploy/aws/.env.example" file and save it as a new file "./deploy/aws/.env". *This new file will not be committed back to source control as it contains personal and sensitive data.
    3. Edit the file "./deploy/aws/.env" and replace the values according to preferences.
    4. If required, for the values "AWS_ACCESS_KEY_ID" and "AWS_SECRET_ACCESS_KEY", create a new access key by visiting ["Your Security Credentials"](https://console.aws.amazon.com/iam/home#/security_credentials), expanding "Access keys" and creating a new key.
    5. Run the command `make install cloud=aws` to create the AWS Elastic Beanstalk Environment and install the application. This command may take a few minutes.
    6. Update the application with the same command `make install cloud=aws`.
    7. Check the application logs with the command `make logs cloud=aws`
    8. Uninstall and clean up the application deployment with the command `make uninstall cloud=aws`. This command may take several seconds.

### :material-microsoft-azure: Microsoft Azure

!!! todo "Prerequisites"

    See the [contributor guide](../contribute.md#development) for more details.

    - An [Azure account](https://azure.microsoft.com/en-us/free/) :octicons-link-16: _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: for standard task execution.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16: for containerized task execution.

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/nodejs/expressjs/webapi`)
    2. Copy the "./deploy/azure/.env.example" file and save it as a new file "./deploy/azure/.env". *This new file will not be committed back to source control as it contains personal and sensitive data.
    3. Edit the file "./deploy/azure/.env" and replace the values according to preferences.
    4. If required, for the values "AZURE_SP_APPID", "AZURE_SP_PASSWORD", and "AZURE_SP_TENANT", create new service principal credentials with the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) :octicons-link-16: and the command `az ad sp create-for-rbac --name "our-hello-sp" --role Contributor`, providing any `--name` as desired.
    5. *You may encounter an error with multiple subscriptions as this has not been tested. Consider a [contribution](https://github.com/ourchitecture/hello-cloud/issues/94).
    6. Run the command `make install cloud=azure` to create the Azure Resource Group, Azure AppService Plan, and AppService if they do not exist as well as to deploy the application.
    7. Check the application logs with the command `make logs cloud=azure`
    8. Uninstall and clean up the application deployment with the command `make uninstall cloud=azure`

### :material-google-cloud: Google Cloud

!!! todo "Prerequisites"

    See the [contributor guide](../contribute.md#development) for more details.

    - An [Google Cloud account](https://cloud.google.com/free) :octicons-link-16: _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - Google Cloud [Billing Account](https://console.cloud.google.com/billing) :octicons-link-16:
    - Once a project is created, you will be prompted to enable [Google Cloud Build](https://cloud.google.com/build) :octicons-link-16:
    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: for standard task execution.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16: for containerized task execution.

!!! attention "Known issues"

      Every attempt has been made to automate the deployment. However, some timing issues have been observed as well as having to manually enable "Code Build" and manually associating dynamically created projects with a billing account. [Contributions are welcome!](https://github.com/ourchitecture/hello-cloud/issues/98)

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/nodejs/expressjs/webapi`)
    2. Copy the "./deploy/gcloud/.env.example" file and save it as a new file "./deploy/gcloud/.env". *This new file will not be committed back to source control as it contains personal and sensitive data.
    3. Edit the file "./deploy/gcloud/.env" and replace the values according to preferences.
    4. Run the command `make install cloud=gcloud` to create a new Google Cloud project, application, and deploy the code.
    5. If the output indicates that billing must be enabled, login to the [projects list](https://console.cloud.google.com/billing/projects) and associate the newly created project with the appropriate billing account (even if you are using free resources)
    6. If the output indicates that "Cloud Build" must be enabled, login to the [projects list](https://cloud.google.com/build) and enable the cloud build API
    7. Check the application logs with the command `make logs cloud=gcloud`
    8. Uninstall and clean up the application deployment with the command `make uninstall cloud=gcloud`

!!! tip "Tip: Project Naming"

      Google Cloud retains deleted projects for a time. If the value for "GCLOUD_PROJECT_ID" in "./deploy/gcloud/.env" already exists as an active project, nothing will be done. If the project has been deleted, the project will be restored. If the project does not exist, it will be created.

### :fontawesome-brands-salesforce: SalesForce Heroku

!!! todo "Prerequisites"

    See the [contributor guide](../contribute.md#development) for more details.

    - A [Heroku account](https://signup.heroku.com/) :octicons-link-16: _\*this project worked with fairly cheap or entirely free infrastructure at the time of its creation_
    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: for standard task execution.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16: for containerized task execution.

!!! example "Commands"

    1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/services/nodejs/expressjs/webapi`)
    2. Copy the "./deploy/heroku/.env.example" file and save it as a new file "./deploy/heroku/.env". *This new file will not be committed back to source control as it contains personal and sensitive data.
    3. Edit the file "./deploy/heroku/.env" and replace the values according to preferences.
    4. Run the command `make install cloud=heroku` to create a new Heroku application and deploy the code.
    5. Check the application logs with the command `make logs cloud=heroku`
    6. Uninstall and clean up the application deployment with the command `make uninstall cloud=heroku`

## Roadmap

???+ info "Started"

    [Start contributing!](../contribute.md){ .md-button }

???+ question "Future"

    - Deploy to cloud Managed Containers (_refers to a "run as container" deployment over full-blown Managed Kubernetes deployment_)
        - "aws"
        - "azure"
        - "gcloud"
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

    - Local "hello-cloud" service (`yarn` or `npm`)
    - Build and run as container (`docker`, `docker-compose`, or `podman`)
    - Deploy container to GitHub Container Registry as GitHub Package
    - GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
    - Deploy to cloud Platform-as-a-Service (PaaS)
        - "aws"
        - "azure"
        - "gcloud"
        - "heroku"
