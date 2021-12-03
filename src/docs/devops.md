# :octicons-infinity-16: DevOps

[![documentation](https://github.com/ourchitecture/hello-cloud/actions/workflows/documentation.yml/badge.svg)](https://github.com/ourchitecture/hello-cloud/actions/workflows/documentation.yml)
[![dotnet_webapi](https://github.com/ourchitecture/hello-cloud/actions/workflows/dotnet_webapi.yml/badge.svg)](https://github.com/ourchitecture/hello-cloud/actions/workflows/dotnet_webapi.yml)
[![java_springboot_webapi](https://github.com/ourchitecture/hello-cloud/actions/workflows/java_springboot_webapi.yml/badge.svg)](https://github.com/ourchitecture/hello-cloud/actions/workflows/java_springboot_webapi.yml)
[![kotlin_springboot_webapi](https://github.com/ourchitecture/hello-cloud/actions/workflows/kotlin_springboot_webapi.yml/badge.svg)](https://github.com/ourchitecture/hello-cloud/actions/workflows/kotlin_springboot_webapi.yml)
[![nodejs_expressjs_webapi](https://github.com/ourchitecture/hello-cloud/actions/workflows/nodejs_expressjs_webapi.yml/badge.svg)](https://github.com/ourchitecture/hello-cloud/actions/workflows/nodejs_expressjs_webapi.yml)

## Local development

:eyes: See the [contributor guide](./contribute.md#development) for local development.

## :material-pipe: Pipelines

Every attempt is made to ensure that all automation tasks done by a server can also be performed by a human. So, continuous integration and deployment shares a lot of the same `make` tasks that a developer would execute on their local machine.

The production pipeline uses [GitHub Actions](https://github.com/ourchitecture/hello-cloud/actions) with the source files under ["./.github/workflows/"](https://github.com/ourchitecture/hello-cloud/tree/main/.github/workflows).

### Documentation

- :material-pipe: **Workflow:** "./.github/workflows/documentation.yml"
- :octicons-code-16: **Source:** "./src/docs"
- :goal: **Deployment(s):** "./docs" and [GitHub Pages](https://www.ourchitecture.io/hello-cloud/)

Documentation is auto-generated using `make install-docs` with [MkDocs](https://www.mkdocs.org/) :octicons-link-16:, [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) :octicons-link-16:, and the ["mkdocs-material"](https://hub.docker.com/r/squidfunk/mkdocs-material/) :octicons-link-16: dockerized task runtime. The result generates the source output of everything contained in "./docs".
