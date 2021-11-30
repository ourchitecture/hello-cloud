# Clouds

Following are some interesting cloud observations while developing basic, automated hello-world deployments for each.

## Cloud Providers

### Amazon Web Services

-   PaaS support for .NET is severely limited, requiring a containerized deployment.
-   PaaS support for Java and Kotlin using Elastic Beanstalk and Corretto 11 complains during `eb deploy` with "Alert: The platform version that your environment is using isn't recommended. There's a recommended version in the same platform branch." This is because specifying `eb init --platform corretto-11 ...` defaults to version "3.2.7", when a newer platform version exists on AWS. [Contributions](./contribute.md) to fix this with a specific platform version are welcomed.

### Microsoft Azure

-   Java and Kotlin PaaS support was challenging as it seems they only support a Maven plug-in, eliminating the ability for projects that target Azure to use Gradle. This is an odd choice, considering Gradle is perhaps equally or more popular than Maven for modern development and the entire Android ecosystem utilizes Gradle.

### Google Cloud

-   Automatically setting up and tearing down PaaS infrastructure seems "quirky" and idempotency is challenging.
-   The command `gcloud app deploy ...` does not properly ignore a "./Dockerfile", even if the "./app.yaml" specifies a standard runtime (not "custom" for docker containers) and the file "./.gcloudignore" explicitly ignores "Dockerfile".

### Salesforce Heroku

-   Does not work out-of-the-box with monorepos, requiring the use of an unsupported [community user buildpack](https://github.com/lstoll/heroku-buildpack-monorepo). Heroku also uses a `git` repository to push code changes. Currently, the entire monorepo must be synchronized with the Heroku repo. Future contribution enhancements could containerize the heroku runtime, mount just the project, initialize git and push the changes. Heroku tooling complains when a "shallow clone" is made (e.g. `git clone --depth=1 ...`). So, without the full history and simulating a new repository with each deploy, the effects of this are unknown.
-   .NET Core is not an officially supported language, requiring the use of an unsupported [community user buildpack](https://github.com/jincod/dotnetcore-buildpack). This is odd, considering C# has been in the top lists of programming languages for professional developers for several years.

## Technology

### Java and Kotlin

Some vendor Platform as a Service (PaaS) solutions are limited to Java 11 with Long-Term Support (LTS), despite the OpenJDK being released every 6 months including newer LTS versions (e.g. v17). Newer Java versions may use containers and examples are provided. See the [Oracle Java SE support roadmap](https://www.oracle.com/java/technologies/java-se-support-roadmap.html) :octicons-link-16: for more.
