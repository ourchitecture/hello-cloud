# DevOps

## Local development

See the [contributor guide](./contribute.md) for local development.

## Pipelines

Every attempt is made to ensure that all automation tasks done by a server can also be performed by a human. So, continuous integration and deployment shares a lot of the same `make` tasks that a developer would execute on their local machine.

The production pipeline uses [GitHub Actions](https://github.com/ericis/hello-cloud/actions) with the source files under ["./.github/workflows/"](https://github.com/ericis/hello-cloud/tree/main/.github/workflows).

### Documentation

- **Workflow:** "./.github/workflows/documentation.yml"
- **Source:** "./src/docs"
- **Deployment(s):** "./docs" and [GitHub Pages](https://ericis.github.io/hello-cloud/)

Documentation is auto-generated using `make install-docs` with [MkDocs](https://www.mkdocs.org/) 🔗, [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) 🔗, and the ["mkdocs-material"](https://hub.docker.com/r/squidfunk/mkdocs-material/) 🔗 dockerized task runtime. The result generates the source output of everything contained in "./docs".

### Projects

- [Java with SpringBoot](./services/java-springboot.md)
- [NodeJS with ExpressJS](./services/nodejs-expressjs.md)
