# Terraform Example
This example creates a SecretHub service account in Terraform and grants it read access to a specified repository.

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed
2. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed

## Running the example

Initialize a terraform working directory by running:
```
terraform init
```

To create the service account, run:
```
terraform apply
```
and provide the requested information.

The credential of the service account will be printed.

> Note that the credential is only printed for demonstration purposes.
> Service credentials must be kept secure and should not be logged.

Moreover, a secret named `test` is also created in the specified repo.

To verify that the service indeed has read access on repo, try reading the test secret with the service credential:
```
SECRETHUB_CREDENTIAL=<your-service-credential> secrethub read <your-username>/<repo>/test
```
