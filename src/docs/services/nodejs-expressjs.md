# Service: NodeJS with ExpressJS

- **Path:** [./src/nodejs/expressjs/webapi/](https://github.com/ericis/hello-cloud/tree/main/src/nodejs/expressjs/webapi)
- **Runtime:** [NodeJS](https://nodejs.org/) 🔗
- **Language:** [JavaScript](https://javascript.info/) 🔗
- **Framework:** [ExpressJS](https://expressjs.com/) 🔗

## Getting started

The [contributor guide](../contribute.md) has the steps necessary to run this project locally.

## Deployments

### Heroku

#### Prerequisites

- A [Heroku account](https://signup.heroku.com/) _\*this project worked with free infrastructure at the time of its creation_
- [`heroku` CLI](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli)

#### Steps to deploy

1. Login to your Heroku account with the CLI using the command `heroku login`
2. Open a terminal and navigate to the service project directory (e.g. `cd ./src/nodejs/expressjs/webapi`)
3. Run the command `make heroku-init` to create and configure the cloud app including assigning the [community monorepo buildpack](https://github.com/lstoll/heroku-buildpack-monorepo#readme) as well as the [node.js buildpack](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-nodejs)
4. Install the application with the command `make heroku-install`
5. Check the application logs with the command `make heroku-logs`
6. Uninstall and clean up the application deployment with the command `make heroku-uninstall`

## Roadmap

Future updates will deploy this service to multiple clouds using various backend infrastructure options.
