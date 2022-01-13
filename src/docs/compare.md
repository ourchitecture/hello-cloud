# Cloud Comparisons

There are a number of general methods to compare these popular cloud offerings without getting too specific that the documentation is always out of date.

## Compare Cloud Development Tools

### Command-Line Interface (CLI)

All clouds offer a local installation as well as an online version.

### Software Development Kit (SDK)

SDKs will vary based on the specific type of services, the preferred programming language, and style of cloud platform interaction.

| AWS                                                                                   | Azure                                                 | GCP         |
| ------------------------------------------------------------------------------------- | ----------------------------------------------------- | ----------- |
| Javascript, Python, PHP, .NET, Ruby, Java, Go, Node.js, C++                           | .NET, Java, JavaScript, Python, GO, C++, C, PHP, Ruby | GCloud CLI  |
| Web, Native Mobile, Internet of Things (IoT), IDE extensions / plug-ins, Command-Line | Internet of Things (IoT), Apple Native Mobile         | Google APIs |

### Web Consoles

| Comparison   | AWS                | Azure  | GCP           |
| ------------ | ------------------ | ------ | ------------- |
| Service Name | Management Console | Portal | Cloud Console |

### Cloud Developer Tools

| Comparison        | AWS                                                                                                                 | Azure                                             | GCP                                    |
| ----------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------- | -------------------------------------- |
| Service Name      | Cloud9                                                                                                              | Visual Studio Code                                | Cloud Code IDE                         |
| Online Experience | :material-check: Yes                                                                                                | :material-check: Yes                              | :material-check: Yes                   |
| Supports          | A variety of programming languages, real-time collaboration, container development, build, test, and debugging code | Implements a comparable online version of VS Code | Integrates into common developer tools |

### Infrastructure as Code

| Comparison   | AWS                  | Azure                                      | GCP                  |
| ------------ | -------------------- | ------------------------------------------ | -------------------- |
| Service Name | CloudFormation       | Azure Resource Manager (ARM) Templates     | Deployment Manager   |
| Language     | YAML                 | JSON with Bicep (domain-specific language) | YAML                 |
| Terraform    | :material-check: Yes | :material-check: Yes                       | :material-check: Yes |

### Local Developer Tools

Ultimately, developers may choose to run any choice of local developer tools and all clouds support the ability to run the artifacts from all languages in some form (e.g. Serverless, PaaS, Containers, or IaaS).

### Developer Tool Resources

| Tool                   | AWS                                                                     | Azure                                                                                          | GCP                                                                                 |
| ---------------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| Developer Tools        | [AWS developer tools](https://aws.amazon.com/products/developer-tools/) | [Azure developer tools](https://azure.microsoft.com/en-us/product-categories/developer-tools/) | [GCP developer tools](https://cloud.google.com/products/tools)                      |
| CLI                    | [AWS CLI](https://aws.amazon.com/cli/)                                  | [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/)                                       | [GCP CLI](https://cloud.google.com/pubsub/docs/quickstart-cli)                      |
| SDKs                   | [AWS SDKs](https://aws.amazon.com/tools/)                               | [Azure SDKs](https://azure.microsoft.com/en-us/downloads/)                                     | [Google Cloud SDK](https://cloud.google.com/sdk)                                    |
| Management             | [AWS Management Console](https://aws.amazon.com/console/)               | [Microsoft Azure Portal](https://azure.microsoft.com/en-us/features/azure-portal/)             | [Google Cloud Console](https://console.cloud.google.com/getting-started)            |
| Developer Environments | [AWS Cloud9](https://aws.amazon.com/cloud9/)                            | [Visual Studio Code](https://code.visualstudio.com)                                            | [Google Cloud Code IDE](https://cloud.google.com/code)                              |
| Infrastructure as Code | [AWS CloudFormation](https://aws.amazon.com/cloudformation/)            | [Azure Resource Manager](https://azure.microsoft.com/en-us/features/resource-manager/)         | [Google Cloud Deployment Manager](https://cloud.google.com/deployment-manager/docs) |

## Compare Cloud Storage

### Object Storage

| Comparison                                    | AWS                         | Azure                | GCP                  |
| --------------------------------------------- | --------------------------- | -------------------- | -------------------- |
| Service Name                                  | Simple Storage Service (S3) | BLOB Storage         | Cloud Storage        |
| Container Name                                | Bucket                      | Container            | Bucket               |
| Versioning, Encryption, Fine-grained security | :material-check: Yes        | :material-check: Yes | :material-check: Yes |
| Less frequently accessed data                 | Infrequently accessed       | Cool BLOB            | Nearline, Coldline   |
| Archiving                                     | Glacier                     | Archive              | Archive              |
| Lifecycle management                          | :material-check: Yes        | :material-check: Yes | :material-check: Yes |

### File Storage

| Comparison   | AWS                                                                          | Azure | GCP       |
| ------------ | ---------------------------------------------------------------------------- | ----- | --------- |
| Service Name | Elastic File System (EFS)<br>Amazon FSx for Windows<br>Amazon FSx for Lustre | Files | Filestore |

### Block Storage

Great for virtual machines, this storage method provides high performance with high IOPS.

| Comparison                                  | AWS                         | Azure                | GCP                                  |
| ------------------------------------------- | --------------------------- | -------------------- | ------------------------------------ |
| Service Name                                | Elastic Block Storage (EBS) | Azure Managed Disks  | Persistent disks & Solid-state disks |
| Flexible storage type and IOPS provisioning | :material-check: Yes        | :material-check: Yes | :material-check: Yes                 |
| Scheduled and ad-hoc snapshots              | :material-check: Yes        | :material-check: Yes | :material-check: Yes                 |

### Data Transport

While all clouds provide web interfaces and command-line tools for uploads, Azure and Amazon also offer localized data sync "transfer gateways" to upload. All clouds also offer hard drive data transfer by mail. Azure offers Data Box Disk with up to 40 TB and Azure Data Box Heavy up to 1 PB. Google Cloud offers their "Transfer Appliance" for up to 1 PB. The Amazon Web Services "Snow Family" has the most variety of physical transfer options including their "Snowmobile", a tractor trailer that can transfer up to 100 PB of data.

## More comparisons...

- Check out [A Cloud Guru Cloud Comparison videos](https://www.youtube.com/c/AcloudGuru/search?query=comparisons).
- Consider [contributing more comparisons](./contribute.md) to this page.
