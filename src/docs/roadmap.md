# Roadmap

!!! important ""

    - **:octicons-book-16: Documentation**
        - [x] Project overview
        - [ ] Cloud for Business
        - [ ] Cloud for Technology Leaders
        - [ ] Cloud for Technology Designers (e.g. architecture)
        - [x] Cloud for Developers
    - **:material-cloud-outline: Clouds**
        - :fontawesome-brands-aws: Amazon Web Services
            - [ ] Functions: Lambda
            - [x] PaaS: Elastic Beanstalk
            - [x] Managed Containers: Elastic Beanstalk
            - [ ] Managed Kubernetes: Elastic Kubernetes Service (EKS)
        - :material-microsoft-azure: Google Cloud
            - [ ] Functions: Google Functions
            - [x] PaaS: AppEngine
            - [x] Managed Containers: AppEngine
            - [ ] Managed Kubernetes: Google Kubernetes Engine (GKE)
        - :material-google-cloud: Microsoft Azure
            - [ ] Functions: Azure Functions
            - [x] PaaS: AppService
            - [x] Managed Containers: AppService
            - [ ] Managed Containers: Azure Container Instance (ACI)
            - [ ] Managed Kubernetes: Azure Kubernetes Service (AKS)
        - :fontawesome-brands-salesforce: Salesforce Heroku
            - [x] PaaS
    - **:material-cloud-upload: Deployments**
        - [x] PaaS
        - [x] Managed Containers (no Kubernetes)
        - [ ] Managed Kubernetes
    - **:material-api: Services**
        - Languages and Frameworks
            - [x] .NET Core C#
            - [ ] Go
            - [x] Java with SpringBoot
            - [x] Kotlin with SpringBoot
            - [x] NodeJS with ExpressJS
            - [ ] Python
            - [ ] Rust
        - Contracts
            - [ ] AsyncAPI
            - [ ] GraphQL
            - [ ] gRPC
            - [ ] OpenAPI
    - **:octicons-browser-16: Web Applications**
        - [ ] Angular
        - [ ] Ionic with StencilJS
        - [ ] Next.js
        - [ ] React
        - [ ] Vue.js
    - **:octicons-infinity-16: DevOps**
        - [x] Build and deploy documentation with MkDocs as GitHub Pages
        - [x] Build and push docker containers
        - [ ] Build and test each project
        - [ ] Automated project deployment (infrastructure and code; create, test and destroy)
        - [ ] Service contract documentation integration (i.e. generate service documentation and integrate with MkDocs)
    - **:woman_technologist_tone5: Developer Features**
        - [x] Cross-platform support
        - [x] Consistent task execution with GNU `make`
        - [x] Containerized task execution with `docker`, `docker-compose`, and `podman`
        - [ ] Containerized cloud tooling (e.g. `aws` and `eb`, `az`, `gcloud`)
        - [ ] Containerized development environment
        - [x] Native tool support e.g. `node`, `yarn` and `npm`; `gradle` (`./gradlew`) and `maven` (`./mvnw`); `dotnet`
        - [x] Consistent development with "./.editorconfig"
        - [x] Consistent styles with Prettier
        - [x] Automated documentation with MkDocs and GitHub Actions
        - [x] CI/CD workflows with GitHub Actions
        - [x] Docker deployment with GitHub Packages and GitHub Container Registry
        - [x] Shared VS Code settings and recommended extensions
        - [ ] VS Code project workspaces

!!! info "Project Roadmaps"

    [:material-dot-net: .NET Service Roadmap](./services/dotnet.md#roadmap)

    [:material-language-java: Java with SpringBoot Service Roadmap](./services/java-springboot.md#roadmap)

    [:material-language-kotlin: Kotlin with SpringBoot Service Roadmap](./services/kotlin-springboot.md#roadmap)

    [:material-nodejs: NodeJS with ExpressJS Service Roadmap](./services/nodejs-expressjs.md#roadmap)
