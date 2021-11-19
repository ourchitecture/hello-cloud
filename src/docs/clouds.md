# Clouds

Following are some interesting cloud observations while developing basic, automated hello-world deployments for each.

## Amazon Web Services

-   PaaS support for .NET is severely limited, requiring a containerized deployment.

## Microsoft Azure

-   Java PaaS support was challenging as it seems they only support a Maven plug-in, eliminating the ability for projects that target Azure to use Gradle. This is an odd choice, considering Gradle is perhaps equally or more popular than Maven for modern development and the entire Android ecosystem utilizes Gradle.

## Google Cloud

-   Automatically setting up and tearing down PaaS infrastructure seems "quirky" and idempotency is challenging.
-   The command `gcloud app deploy ...` does not properly ignore a "./Dockerfile", even if the "./app.yaml" specifies a standard runtime (not "custom" for docker containers) and the file "./.gcloudignore" explicitly ignores "Dockerfile".

## Salesforce Heroku

-   Does not work out-of-the-box with monorepos, requiring the use of an unsupported [community user buildpack](https://github.com/lstoll/heroku-buildpack-monorepo). Heroku also uses a `git` repository to push code changes. Currently, the entire monorepo must be synchronized with the Heroku repo. Future contribution enhancements could containerize the heroku runtime, mount just the project, initialize git and push the changes. Heroku tooling complains when a "shallow clone" is made (e.g. `git clone --depth=1 ...`). So, without the full history and simulating a new repository with each deploy, the effects of this are unknown.
-   .NET Core is not an officially supported language, requiring the use of an unsupported [community user buildpack](https://github.com/jincod/dotnetcore-buildpack). This is odd, considering C# has been in the top lists of programming languages for professional developers for several years.
