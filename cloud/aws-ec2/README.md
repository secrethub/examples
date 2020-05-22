# Deploying to AWS EC2 using Terraform
This example creates an EC2 instance with an associated IAM Role that can be used by the instance to authenticate to SecretHub.

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed
2. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
3. Correctly configured [AWS Credentials](https://www.terraform.io/docs/providers/aws/index.html#authentication)

## Running the example

Init the SecretHub demo repo with example values
```
secrethub demo init
```

Initialize a new Terraform working directory
```
terraform init
```

To build the infrastructure run
```
terraform apply
```
and provide the requested values.
