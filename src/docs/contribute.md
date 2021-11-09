# Contributing

👋🏼 Welcome and we are glad you are interested in contributing!

## Development

This project attempts to support a variety of developer tooling choices while maintaining a standard that everyone can test against.

### Prerequisites

**⚠️ Windows users: 👉🏼** _task automation assumes a POSIX-compatible shell with Linux commands that work across most distributions and macOS. As a result, using [Windows Subsystem for Linux (WSL2)](https://docs.microsoft.com/en-us/windows/wsl/install) 🔗 is recommended with a Linux distribution like Debian, Ubuntu, or Kali Linux. You may also use [Git BASH](https://gitforwindows.org/) 🔗 with [`make` for Git BASH](https://gist.github.com/evanwill/0207876c3243bbb6863e65ec5dc3f058#make) 🔗 installed or [cygwin](https://cygwin.com/) 🔗 with [`make` for cygwin](https://cygwin.com/cgi-bin2/package-cat.cgi?file=x86_64%2Fmake%2Fmake-4.3-1&grep=make) 🔗 installed. You could also use a Linux virtual machine running on [Windows Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) 🔗, [Oracle VirtualBox](https://www.virtualbox.org/) 🔗, or even using a [VS Code "devcontainer"](https://code.visualstudio.com/docs/remote/containers) 🔗._

#### Tools

##### Required

- [`git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 🔗 for source control.
- [`docker`](https://www.docker.com/get-started) 🔗, [`docker-compose`](https://docs.docker.com/compose/gettingstarted/) 🔗, or [`podman`](https://podman.io/getting-started/) 🔗 are required to build the documentation and production container images.

##### Recommended

- [GNU `make`](https://www.gnu.org/software/make/) 🔗 is required for DevOps pipelines Continuous Integration (CI) and Deployment (CD) tasks. For consistency, this install is recommended. (_Windows users: see note above_)

##### Optional

- [`yarn`](https://yarnpkg.com/) 🔗 or [`node`](https://nodejs.org/) 🔗 are required to run NodeJS projects (_`yarn` is recommended_). The version of `yarn` is "pinned" in ".yarnrc" and will be automatically selected and used by the `yarn` command. However, container runtimes make this installation optional.
- [`nvm`](https://github.com/nvm-sh/nvm) 🔗 can make switching between specific versions of `node`, `npm`, and `npx` easier across projects for a more consistent project experience across machines. The version of `node` is "pinned" in ".nvmrc" and will be automatically selected and used by the `nvm use` command. However, container runtimes make this installation optional.
- [`java` OpenJDK](https://openjdk.java.net/install/) 🔗 is required to run Java projects. However, container runtimes make this installation optional.
- [VS `code`](https://code.visualstudio.com/) 🔗 may be used for an improved developer experience with support for project-specific settings, extensions, and tasks.
- [`git-town`](https://www.git-town.com/install.html) 🔗 may be used for improved developer workflow.

##### Avoid

- Use of a global installations of `gradle` and/or `maven` are not needed or recommended. This project uses [Gradle wrapper](https://docs.gradle.org/current/userguide/gradle_wrapper.html) and [Maven wrapper](https://github.com/takari/maven-wrapper) with a pinned, project-specific version to ensure version consistency across machines.

### Executing tasks

Task execution consistency can be critical when developing and triaging code. While many tools are supported, "there is only one way" for production, including the DevOps pipeline automation tasks. Local development machines and even DevOps pipeline machines have different Operating Systems, middleware tools, and configurations; they cannot be trusted to be reliable. Therefore, the "one way" is through containers and the default tool of choice is `docker` 🐳; while this project would prefer to use a completely free and open source ecosystem like `podman` 🥰💖, `docker` is well established, virtually ubiquitous on most local and DevOps machines, and [mostly free](https://www.docker.com/blog/updating-product-subscriptions/) 🔗 💸.

All automation tasks are abstracted behind `make` ⚙️ command targets. This enables task consistency across projects and tooling. You may run most commands using your choice of `podman`, `docker`, `docker-compose`, `gradle` or `maven` (for Java projects), `yarn` or `node` / `npm` (for Node projects) by adding a "dev_tool" parameter to the `make` command, where the value of the parameter matches your preferred tool (e.g. `make install dev_tool=yarn` or `make start dev_tool=podman`). However, `docker` is recommended as the default tool used by DevOps pipeline tasks for production build, test, and deploy.

If you do not wish to use `make` (e.g. `npm install && npm start` or `yarn && yarn start`; `./gradlew bootRun` or `./mvnw spring-boot:run`), review the commands in the "./makefile" and construct the appropriate command or simply try out what you expect to work.

### Running tasks

1. Clone the repository with the command `git clone --depth=1 https://github.com/ericis/hello-cloud`
2. Navigate to the project in a terminal or open your favorite editor
3. Build the project with the command `make` or `make install` (`make build` will also work)
4. Test the system with the command `make check` (`make test` will also work)
5. Start the system with the command `make start` (`make run` , `make up` and `make serve` will also work)
6. Stop the system with the default command `make stop` (`make down` will also work). If you use an alternative tool running as a foreground process (e.g. `yarn start`), simply kill the process (e.g. <kbd>Command</kbd> + <kbd>.</kbd> on macOS or <kbd>Ctrl</kbd> + <kbd>C</kbd> on Windows).
7. Clean up temporary task artifacts with the command `make clean` (`make uninstall` will also work)
