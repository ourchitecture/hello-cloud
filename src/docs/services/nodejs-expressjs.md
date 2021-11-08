# Service: NodeJS with ExpressJS

- **Path:** [./src/nodejs/expressjs/webapi/](https://github.com/ericis/hello-cloud/tree/main/src/nodejs/expressjs/webapi)
- **Runtime:** [NodeJS](https://nodejs.org/) 🔗
- **Language:** [JavaScript](https://javascript.info/) 🔗
- **Framework:** [ExpressJS](https://expressjs.com/) 🔗

## Getting started

The [contributor guide](../contribute.md) has the steps necessary to run this project locally.

## Deployments

### Amazon Web Services (AWS)

#### Prerequisites

- An [AWS account](https://aws.amazon.com/free/) _\*this project worked with free infrastructure at the time of its creation_
- [`eb` CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)

#### Steps to deploy

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/nodejs/expressjs/webapi`)
2. Run the command `make aws-init` to create the AWS Elastic Beanstalk Environment. This command may take a few minutes. The `eb` CLI will prompt you for access credentials. Create a new access key by visiting ["Your Security Credentials"](https://console.aws.amazon.com/iam/home#/security_credentials), expanding "Access keys" and creating a new key.
3. Install the application with the command `make aws-install`. This command may take several seconds.
4. Check the application logs with the command `make aws-logs`
5. Uninstall and clean up the application deployment with the command `make aws-uninstall`. This command may take several seconds.

### Microsoft Azure

#### Prerequisites

- An [Azure account](https://azure.microsoft.com/en-us/free/) _\*this project worked with free infrastructure at the time of its creation_
- [`az` CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

#### Steps to deploy

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/nodejs/expressjs/webapi`)
2. Login to your Azure account with the CLI using the command `az login`
3. If you have more than one subscription, first [set the default subscription](https://docs.microsoft.com/en-us/azure/developer/javascript/tutorial/tutorial-vscode-azure-cli-node/tutorial-vscode-azure-cli-node-03#set-your-default-subscription)
4. Run the command `make azure-init` to create the Azure Resource Group
5. Install the application with the command `make azure-install`
6. Check the application logs with the command `make azure-logs`
7. Uninstall and clean up the application deployment with the command `make azure-uninstall`

### SalesForce Heroku

#### Prerequisites

- A [Heroku account](https://signup.heroku.com/) _\*this project worked with free infrastructure at the time of its creation_
- [`heroku` CLI](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli)

#### Steps to deploy

1. Open a terminal and navigate to the service project directory (e.g. `cd ./src/nodejs/expressjs/webapi`)
2. Login to your Heroku account with the CLI using the command `heroku login`
3. Run the command `make heroku-init` to create and configure the cloud app including assigning the [community monorepo buildpack](https://github.com/lstoll/heroku-buildpack-monorepo#readme) as well as the [node.js buildpack](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-nodejs)
4. Install the application with the command `make heroku-install`
5. Check the application logs with the command `make heroku-logs`
6. Uninstall and clean up the application deployment with the command `make heroku-uninstall`

## Roadmap

Future updates will deploy this service to multiple clouds using various backend infrastructure options.
