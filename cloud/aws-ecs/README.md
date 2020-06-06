# Deploying to AWS EC2 using Terraform
This example creates an ECS cluster and deploys the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) to it and provisions it with the required secrets using the [SecretHub AWS Identity Provider](https://secrethub.io/docs/reference/aws/).

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed
2. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
3. Correctly configured [AWS Credentials](https://www.terraform.io/docs/providers/aws/index.html#authentication)

## Running the example

Init the SecretHub demo repo with example values
```
secrethub demo init
```

To launch an example ECS cluster, run:
```
terraform init
terraform apply
```

Get the public IP of the cluster from the AWS console or using the AWS CLI and visit `http://<PUBLIC-IP>` to see the app running.
