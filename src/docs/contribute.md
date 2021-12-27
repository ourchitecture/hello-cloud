# Contributing

:wave_tone5: Welcome and we are glad you are interested in contributing!

!!! tip "Ways to contribute"

    - **:octicons-comment-discussion-16: Discuss:** post a comment at the bottom of every page
    - [**:octicons-issue-opened-16: Submit an issue**](https://github.com/ourchitecture/hello-cloud/issues)
    - [**:material-comment-plus: Comment on an issue**](https://github.com/ourchitecture/hello-cloud/issues)
    - [**:material-star: Star**](https://github.com/ourchitecture/hello-cloud)
    - [**:material-eye-plus: Watch**](https://github.com/ourchitecture/hello-cloud/subscription)
    - [**:material-new-box: Create a project**](#adding-a-new-project)
    - [**:woman_technologist_tone4: :man_technologist_tone3: :woman_technologist_tone5: :man_technologist_tone2: :technologist_tone1: Development**](#development)

!!! warning "./docs"

    _The "./docs" folder is automatically generated output. Please make changes to "./src/docs"._

## Adding a new project

Is your favorite language and/or framework to build a website or web service missing from this project? What great ideas to you have to demonstrate getting systems to the cloud?

### A working program

???+ num-one "1. The 'Hello World' program"

    1. Check if the idea is already on [the roadmap](./roadmap.md) or has already been submitted as [an issue](https://github.com/ourchitecture/hello-cloud/issues).
    2. [Submit an issue](https://github.com/ourchitecture/hello-cloud/issues) that describes your idea to start a discussion.
    3. [Fork this project](https://github.com/ourchitecture/hello-cloud/fork) and clone it to your local system.
    4. Review the "Development" steps below.
    [//]: # "BUG: when the link below used ../index.md#projects, it resulted in /hello-cloud#projects and a 404 error"
    5. Review one of the [existing projects](./index.md#projects) for similarities to your idea.
    6. Create a new directory for your source code (e.g. "./src/services/[language/framework]" for web services or "./src/apps/[language/framework]" for web applications).
    7. Add a basic "hello world" example using the language and framework of choice.
    8. Commit small, working changes regularly and please use ["conventional commit messages"](https://www.conventionalcommits.org/en/v1.0.0/). You can see [existing examples of commit messages](https://github.com/ourchitecture/hello-cloud/commits/main).
    9. Automate the developer tasks by creating a new "./makefile" in your project, copy command targets from an existing "./makefile" from another project and customize the commands to work with your language and framework. Ignore any deployment commands for now and also ignore command targets you are not ready or not sure how to implement.
    10. Commit your changes.
    11. Add the path to your project in the root "./makefile" in the space-separated "project_dirs" variable list. This will enable developers to build and run all projects at the same time, including yours.
    12. Commit your changes.
    13. Submit a ["draft pull request"](https://github.blog/2019-02-14-introducing-draft-pull-requests/) back to this project.
    14. We will start a discussion on the proposed implementation. Please be open to making any suggested changes.

<figure>
<div class="mermaid mermaid-sequence">sequenceDiagram
    participant C as Contributor
    participant M as Maintainer
    participant R as Repository

    C->>R: Check roadmap
    C->>R: Submit issue
    M->>R: Review issue
    M->>C: Discuss issue
    C->>R: Clone
    C->>C: Create new project
    C->>R: Submit "draft" PR
    loop PR Review
      M->>R: Review PR
      M->>C: Discuss PR
      C->>C: Make any changes
      C->>R: Push changes
    end
</div>
<figcaption>Hello World</figcaption>
</figure>

???+ num-two "2. Containers"

    Once you have a basic "hello world" example working, it's time to containerize your build and test workflow as well as the system deployment, so that it can be executed by any Open Container Initiative-compatible runtime across machines including locally by developers and DevOps pipeline automation.

    1. Review an existing "./makefile" from another project and customize your project's commands to work with `docker`, `docker-compose` and `podman`.
    2. Hopefully, a base docker image will already exist to mount and execute your application (e.g. [node](https://hub.docker.com/_/node)). If so, use this as your base. If not, consider choosing [Alpine Linux](https://hub.docker.com/_/alpine), [Debian](https://hub.docker.com/_/debian), or [Ubuntu](https://hub.docker.com/_/ubuntu) for your base image.
    3. Create a "Dockerfile" and test your container locally.
    4. Commit your changes.
    5. Update your existing Pull Request so that we can discuss the container work.

<figure>
<div class="mermaid mermaid-sequence">sequenceDiagram
    participant C as Contributor
    participant M as Maintainer
    participant R as Repository

    C->>C: Containerize system
    C->>R: Push changes
    loop PR Review
      M->>R: Review PR
      M->>C: Discuss PR
      C->>C: Make any changes
      C->>R: Push changes
    end
</div>
<figcaption>Containers</figcaption>
</figure>

???+ num-three "3. Writing documentation"

    Once you have a working container, it's time to start documenting your project.

    1. Copy and paste an existing project's markdown file from "./src/docs/" (e.g. ./src/docs/services/nodejs-expressjs.md).
    2. Review and edit the sections to match, customizing links and commands to match your project's needs.
    3. Delete any cloud deployment sections at this time.
    4. Commit your changes.
    5. Add links to your project documentation in "./mkdocs.yml" as well as "./src/docs/index.md" (both are under "Projects").
    6. Commit your changes.
    7. Update your existing Pull Request so that we can discuss the documentation.

<figure>
<div class="mermaid mermaid-sequence">sequenceDiagram
    participant C as Contributor
    participant M as Maintainer
    participant R as Repository

    C->>C: Document system
    C->>R: Push changes
    loop PR Review
      M->>R: Review PR
      M->>C: Discuss PR
      C->>C: Make any changes
      C->>R: Push changes
    end
</div>
<figcaption>Documentation</figcaption>
</figure>

???+ num-four "4. Integrating a DevOps pipeline"

    Documentation for all projects will be automatically built through [the "documentation" pipeline](./devops.md#documentation). However, we need to build and publish your project's docker container.

    1. Copy and paste an existing project's GitHub Actions pipeline workflow ".yml" configuration from "./.github/workflows/".
    2. Customize the names and paths to match your project. It will not be possible to test this workflow.
    3. Commit your changes.
    4. Update your existing Pull Request so that we can discuss the workflow.

<figure>
<div class="mermaid mermaid-sequence">sequenceDiagram
    participant C as Contributor
    participant M as Maintainer
    participant R as Repository

    C->>C: Create GitHub Actions workflow
    C->>R: Push changes
    loop PR Review
      M->>R: Review PR
      M->>C: Discuss PR
      C->>C: Make any changes
      C->>R: Push changes
    end
</div>
<figcaption>Container DevOps</figcaption>
</figure>

???+ num-five "5. Finalize PR"

    Although your project has not even been deployed to a major cloud provider yet, the basic foundation now exists to integrate cloud automation tasks. If your PR is finalized and has been approved, we will merge your PR to the "main" branch, your project container will be built and published, and your project will be added to the public documentation. This now provides others with a chance to build on top of your project too.

<figure>
<div class="mermaid mermaid-sequence">sequenceDiagram
    participant C as Contributor
    participant M as Maintainer
    participant R as Repository
    participant GHA as GitHub Actions
    participant GHPkg as GitHub Packages
    participant GHPages as GitHub Pages
    participant site as Ourchitecture.io

    loop PR Review
      M->>R: Review PR
      M->>C: Discuss PR
      C->>C: Make any changes
      C->>R: Push changes
    end

    M->>R: Approve PR
    M->>R: Merge PR to "main"
    GHA->>GHPkg: Generate docker image
    GHA->>R: Generate documentation
    GHA->>R: Submit documentation PR
    M->>R: Approve and merge documentation PR
    GHPages->>R: Read "./docs"
    GHPages->>site: Update public documentation site
</div>
<figcaption>Finalize PR</figcaption>
</figure>

### Cloud deployments

Once we have a working, containerized program, we can begin cloud deployment automation tasks.

???+ num-one "1. Pick just one cloud"

    1. Pick one of the major cloud providers that you will target a deployment for (e.g. AWS, Azure, GCP, or Heroku). If your cloud provider is not in this list, please first propose a new one by [submitting an issue](https://github.com/ourchitecture/hello-cloud/issues) and we can discuss the proposal. Please understand that your request could be denied. You will need an account that may incur costs when testing your cloud deployment. Most "hello world" implementations are free or very cheap on major cloud providers, especially if you focus on automating destruction of cloud resources and destroy them immediately after creating them and testing for success.
    2. Review an existing project's cloud deployment documentation.
    3. Review an existing project's "./makefile" cloud deployment command targets.
    4. Begin work to add your own cloud deployment command targets to your project's "./makefile".
    5. Commit your changes.
    6. Begin to document the steps by copying and pasting the cloud section from an existing project and customizing as required.
    7. Commit your changes.
    8. Update your project's "Roadmap" section with what has been completed and possible next steps.
    9. Commit your changes.
    10. Submit another "draft pull request" back to this project to start the discussion on your cloud deployment tasks. Please be open to making any suggested changes.

???+ num-two "2. Finalize PR"

    We will work to test the cloud deployment. If your PR is finalized and has been approved, we will merge your PR to the "main" branch and your project's cloud deployment documentation will be updated in the public documentation.

???+ num-three "3. Enhance, enhance, enhance"

    As you did in the first step, you and even others may continue to enhance this great project!

## Development

This project attempts to support a variety of developer tooling choices while maintaining a standard that everyone can test against.

!!! info "Development resources"

    - [**:octicons-issue-opened-16: Submit an issue**](https://github.com/ourchitecture/hello-cloud/issues)
    - [**:material-comment-plus: Comment on an issue**](https://github.com/ourchitecture/hello-cloud/issues)
    - [**:material-star: Star**](https://github.com/ourchitecture/hello-cloud)
    - [**:material-eye-plus: Watch**](https://github.com/ourchitecture/hello-cloud/subscription)
    - [**:octicons-repo-forked-16: Fork**](https://github.com/ourchitecture/hello-cloud/fork)

### Prerequisites

!!! danger "Windows users"

    Task automation assumes a POSIX-compatible shell with Linux commands that work across most distributions and macOS. As a result, using [Windows Subsystem for Linux (WSL2)](https://docs.microsoft.com/en-us/windows/wsl/install) :octicons-link-16: is recommended with a Linux distribution like Debian, Ubuntu, or Kali Linux. You may also use [Git BASH](https://gitforwindows.org/) :octicons-link-16: with [`make` for Git BASH](https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058#make) :octicons-link-16: installed or [cygwin](https://cygwin.com/) :octicons-link-16: with [`make` for cygwin](https://cygwin.com/cgi-bin2/package-cat.cgi?file=x86_64%2Fmake%2Fmake-4.3-1&grep=make) :octicons-link-16: installed. You could also use a Linux virtual machine running on [Windows Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) :octicons-link-16:, [Oracle VirtualBox](https://www.virtualbox.org/) :octicons-link-16:, or even using a [VS Code "devcontainer"](https://code.visualstudio.com/docs/remote/containers) :octicons-link-16:.

### Tools

!!! danger "Avoid"

    Global installations of `gradle` or `maven` are not needed or recommended. The Java and Kotlin projects use [Gradle wrapper](https://docs.gradle.org/current/userguide/gradle_wrapper.html) and [Maven wrapper](https://github.com/takari/maven-wrapper) with a pinned, project-specific version to ensure version consistency across machines.

!!! success "Required"

    - [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) :octicons-link-16: for source control.
    - [`docker`](https://www.docker.com/get-started) :octicons-link-16:, [`docker-compose`](https://docs.docker.com/compose/gettingstarted/) :octicons-link-16:, or [`podman`](https://podman.io/getting-started/) :octicons-link-16: are required to build the documentation and production container images.

!!! info "Recommended"

    - [GNU `make`](https://www.gnu.org/software/make/) :octicons-link-16: is required for DevOps pipelines Continuous Integration (CI) and Deployment (CD) tasks. For consistency, this install is recommended. (_Windows users: see note above_)

??? question "Optional..."

    - [`yarn`](https://yarnpkg.com/) :octicons-link-16: or [`node`](https://nodejs.org/) :octicons-link-16: are required to run NodeJS projects (_`yarn` is recommended_). The version of `yarn` is "pinned" in ".yarnrc" and will be automatically selected and used by the `yarn` command. However, container runtimes make this installation optional.
    - [`nvm`](https://github.com/nvm-sh/nvm) :octicons-link-16: can make switching between specific versions of `node`, `npm`, and `npx` easier across projects for a more consistent project experience across machines. The version of `node` is "pinned" in ".nvmrc" and will be automatically selected and used by the `nvm use` command. However, container runtimes make this installation optional.
    - [`java` 11 OpenJDK](https://openjdk.java.net/install/) :octicons-link-16: is required to run Java and Kotlin projects. However, container runtimes make this installation optional.
    - [`dotnet` 6 SDK](https://dotnet.microsoft.com/download) :octicons-link-16: is required to run .NET projects. However, container runtimes make this installation optional.
    - [VS `code`](https://code.visualstudio.com/) :octicons-link-16: may be used for an improved developer experience with support for project-specific settings, extensions, and tasks.
    - [`git-town`](https://www.git-town.com/install.html) :octicons-link-16: may be used for improved developer workflow.

### Executing tasks

!!! abstract ""

    Task execution consistency can be critical when developing and triaging code. While many tools are supported, "there is only one way" for production, including the DevOps pipeline automation tasks. Local development machines and even DevOps pipeline machines have different Operating Systems, middleware tools, and configurations; they cannot be trusted to be reliable. Therefore, the "one way" is through containers and the default tool of choice is `docker` :material-docker:; while this project would prefer to use a completely free and open source ecosystem like `podman` :heart_eyes: :sparkling_heart:, `docker` is a well established project, virtually ubiquitous on most local and DevOps machines, and [mostly free](https://www.docker.com/blog/updating-product-subscriptions/) :octicons-link-16: :money_with_wings:.

!!! example "Commands that work across all projects"

    All automation tasks are abstracted behind `make` :octicons-gear-16: command targets. This enables task consistency across projects and tooling. You may run most commands using your choice of `podman`, `docker`, `docker-compose`, `gradle` or `maven` (for Java and Kotlin projects), `yarn` or `node` / `npm` (for Node projects), or `dotnet` (for .NET projects) by adding a "dev_tool" parameter to the `make` command, where the value of the parameter matches your preferred tool (e.g. `make install dev_tool=yarn`; `make start dev_tool=podman`; `make run dev_tool=dotnet`). However, `docker` is recommended as the default "dev_tool", since it is also used by DevOps pipeline tasks for production build, test, and deploy.

    1. Clone the repository with the command `git clone --depth=1 https://github.com/ourchitecture/hello-cloud` (:fontawesome-brands-salesforce: SalesForce Heroku [rejects pushes from shallow clones](https://devcenter.heroku.com/changelog-items/775), so remove the ` --depth=1` argument)
    2. Navigate to the project in a terminal or open your favorite editor
    3. Build the project with the command `make` or `make install` (`make build` will also work)
    4. Test the system with the command `make check` (`make test` will also work)
    5. Start the system with the command `make start` (`make run` , `make up` and `make serve` will also work)
    6. Stop the system with the default command `make stop` (`make down` will also work). If you use an alternative tool running as a foreground process (e.g. `yarn start`), simply kill the process (e.g. ++cmd+period++ on macOS or ++ctrl+c++ on Windows).
    7. Clean up temporary task artifacts with the command `make clean` (`make uninstall` will also work)

??? hint "Using locally installed tools..."

    If you do not wish to use `make`, review the commands in the "./makefile" and construct the appropriate command or simply try out what you expect to work.

    ```shell
    # instead of using make across all projects
    # and not needing to know specific tools or their arguments
    # and even forgetting exactly which command to use
    # among other synonym alternatives...
    # example:
    $ make start # or make [start,run,up,serve]
    # and, instead of running make with a variety of tooling choices...
    # examples:
    $ make start dev_tool=podman
    $ make start dev_tool=docker
    $ make start dev_tool=docker-compose
    $ make start dev_tool=node
    $ make start dev_tool=npm
    $ make start dev_tool=yarn
    $ make start dev_tool=gradle
    $ make start dev_tool=gradlew
    $ make start dev_tool=maven
    $ make start dev_tool=mvn
    $ make start dev_tool=mvnw
    $ make start dev_tool=dotnet

    # ... you can use the tools themselves directly
    # this is especially useful for getting things working
    # however, once things are working,
    # it's great to go back and re-test the make commands
    # to ensure consistent command definitions and execution
    # across machines (developers and DevOps pipelines)

    # run a NodeJS project with native commands
    # (may have project-specific arguments)
    $ npm install && npm start
    $ yarn && yarn start

    # run a Java or Kotlin project with native commands
    # (may have project-specific arguments)
    $ ./gradlew bootRun
    $ ./mvnw spring-boot:run

    # run a .NET Core project with native commands
    # (may have project-specific arguments)
    $ dotnet run
    ```

## Maintainers

Project maintainers serve as leading contributors to the project's vision and development and are responsible for developing and supporting the project community as a whole.

- [Monitor and review pull requests](https://github.com/ourchitecture/hello-cloud/pulls) at least weekly
- [Monitor and review issues](https://github.com/ourchitecture/hello-cloud/issues) at least weekly
- [Monitor and review pipelines](https://github.com/ourchitecture/hello-cloud/actions) at least weekly
- [Moderate Disqus comments](https://hello-cloud.disqus.com/admin/moderate/all)
- Occassionally, run `make check-versions`, review the logs and search for opportunities to upgrade the versions (e.g. docker image versions, OS middleware versions, programming language and framework versions, code package dependency versions, etc.)
- Occassionally, [review the site](https://www.ourchitecture.io/hello-cloud/)
- Occassionally, follow the "Contributor guidelines" and tutorials from scratch; delete any previously cloned local repository

### Docker images

New docker images should appear in the [list of "packages"](https://github.com/orgs/ourchitecture/packages?repo_name=hello-cloud). However, the first time a docker package is built, it does not seem to be properly associated with the "hello-cloud" repository, does not have "Write" permissions for GitHub Actions and is not listed as "Public" for others to see.

1. Find the docker package by reviewing the GitHub Actions build output for the docker image URL and visit the URL. e.g. [ghcr.io/ourchitecture/hello-cloud/our-hello-nodejs-expressjs-webapi:latest](ghcr.io/ourchitecture/hello-cloud/our-hello-nodejs-expressjs-webapi:latest)
2. Ensure the package is associated with the "hello-cloud" repository and that the "./README.md" appears in the package.
3. Edit the "Package settings" for the package Manage Actions access
4. Ensure that the "hello-cloud" repository has "Write" permissions under "Manage Actions access"
5. Check that "Change package visibility" is set to "Public"
