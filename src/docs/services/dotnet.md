# Service: .NET Core

- **Path:** [./src/services/dotnet/webapi/](https://github.com/ericis/hello-cloud/tree/main/src/services/dotnet/webapi)
- **Runtime:** [.NET Core](https://dotnet.microsoft.com/) 🔗
- **Language:** [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) 🔗
- **Framework:** [ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 🔗

## Getting started

The [contributor guide](../contribute.md) has the steps necessary to run this project locally.

## DevOps

- **Tasks:** [`make`](../contribute.md)
- **Source:** ["./src/services/dotnet/webapi"](https://github.com/ericis/hello-cloud/tree/main/src/services/dotnet/webapi/)

## Roadmap

- ✅ Local "hello-cloud" service (`dotnet`)
- ⬜ Build and run as container (`docker`, `docker-compose`, or `podman`)
- ⬜ Deploy container to GitHub Container Registry as GitHub Package
- ⬜ GitHub Action workflow to build and deploy container to GitHub Container Registry as GitHub Package
- ⬜ Deploy to cloud Platform-as-a-Service (PaaS) ("aws", "azure", "gcloud", "heroku")
- ⬜ Deploy to cloud Managed Containers ("aws", "azure", "gcloud", "heroku") _\*prefer "run as container" deployment over full-blown Managed Kubernetes deployment_
- ⬜ GitHub Actions workflow to deploy this service to multiple clouds (automation of infrastructure setup and tear-down)
- ⬜ Service contracts and auto-generated documentation integrated with MkDocs documentation site
- ⬜ Ping / Health endpoint
