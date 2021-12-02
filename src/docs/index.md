# Hello Cloud

!!! abstract "Our Mission"

    The "Hello Cloud" project seeks to provide an objective, hands-on approach to cloud computing; where observations are made with interactive examples.

    > Just how easy is it for a developer to automate a basic "hello world" program in the cloud?

    While each major cloud provider offers similar tutorials, they tend to focus almost entirely on _manual website interactions_ to setup and execute each tutorial; creating infrastructure and deploying code is often demonstrated via graphical interface rather than completely through automation. Most engineers will need to figure out how to automate these tasks for consistent execution by a team of engineers as well as by workflows of DevOps toolchains and pipelines for continuous integration and deployment (CI/CD). Automation and consistency is a goal of this project while leveraging the unique capabilities each cloud has to offer.

---

<div class="my-btn-group" style="text-align:center" markdown="block">

[:material-gift: Contribute](https://github.com/ourchitecture/hello-cloud){ .md-button }
[:octicons-issue-opened-16: Issues](https://github.com/ourchitecture/hello-cloud/issues){ .md-button }

[:material-star: Star](https://github.com/ourchitecture/hello-cloud){ .md-button }
[:material-eye-plus: Watch](https://github.com/ourchitecture/hello-cloud/subscription){ .md-button }
[:octicons-repo-forked-16: Fork](https://github.com/ourchitecture/hello-cloud/fork){ .md-button }

</div>

---

<figure>
<div class="mermaid mermaid-flowchart">flowchart LR
    subgraph cloud [Cloud Provider]
    aws([Amazon Web Services])
    azure([Microsoft Azure])
    gcloud([Google Cloud])
    heroku([Salesforce Heroku])
    end

    subgraph compute [Compute Abstraction]
    function(Functions)
    application(Applications)
    container(Containers)
    orchestration(Container Orchestration)
    end

    aws --o|AWS Lamda| function
    aws --o|AWS Elastic Beanstalk| application
    aws --o|AWS Elastic Beanstalk| container
    aws --o|"AWS Elastic Kubernetes Service (EKS)"| orchestration

    azure --o|Azure Functions| function
    azure --o|Azure AppService| application
    azure --o|Azure AppService| container
    azure --o|"Azure Kubernetes Service (AKS)"| orchestration

    gcloud --o|Google Cloud Functions| function
    gcloud --o|Google AppEngine| application
    gcloud --o|Google AppEngine| container
    gcloud --o|"Google Kubernetes Engine (GKE)"| orchestration

    heroku --o|Heroku Dynos| application
    heroku --o|Heroku Dynos| container
</div>
<figcaption>Mapping Cloud Providers to Compute Abstractions</figcaption>
</figure>

`Functions`
: For the purposes of this effort, Cloud Functions allows the developer to generally focus on the programming language, libraries and integrations without worrying about an application runtime. The term "Serverless" or the phrase "Functions as a Service" (FaaS) usually refer to this type of deployment.

`Applications`
: This type of deployment allows the developer to focus on the application's programming language, libraries, integrations, application runtime, and frameworks without worrying about containers with an Operating System, Middleware, and the patching that comes with it. There is some nuance to the phrase "Platform as a Service" (PaaS); generally, the use of PaaS often refers to this type of deployment. Of course, a cloud provider may be using containers behind the scenes.

`Containers`
: Managed containers allow the developer to containerize their system and rely on the cloud for container deployment, scaling and management.

`Container Orchestration`
: Managed Kubernetes offerings are the ubiquitous technology supporting this type of deployment. Here, developers rely on the cloud to setup and manage a Kubernetes installation, but must configure and manage the installation, including containers.

---

## Clouds

<a name="clouds"></a>
!!! info ""

    [:fontawesome-brands-aws: Amazon Web Services](./clouds.md#amazon-web-services)

    [:material-microsoft-azure: Microsoft Azure](./clouds.md#microsoft-azure)

    [:material-google-cloud: Google Cloud](./clouds.md#google-cloud)

    [:fontawesome-brands-salesforce: Salesforce Heroku](./clouds.md#salesforce-heroku)

## Projects

<a name="projects"></a>
!!! info ""

    [:material-dot-net: .NET](./services/dotnet.md)

    [:material-language-java: Java with SpringBoot](./services/java-springboot.md)

    [:material-language-kotlin: Kotlin with SpringBoot](./services/kotlin-springboot.md)

    [:material-nodejs: NodeJS with ExpressJS](./services/nodejs-expressjs.md)

## Resources

!!! tip ""

    :writing_hand_tone2: [Make a contribution](./contribute.md)

    :material-pipe: Learn about the [DevOps pipeline](./devops.md)

    :material-road: See where things are headed on [the roadmap](./roadmap.md)
