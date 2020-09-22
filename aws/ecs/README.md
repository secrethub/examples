<p align="center">
  <img src="https://secrethub.io/img/integrations/aws-ecs/github-banner.png?v1" alt="AWS ECS + SecretHub" width="390">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/docs/guides/aws-ecs/"><img alt="View Docs" src="https://secrethub.io/img/buttons/github/view-docs.png?v2" height="28" /></a>
</p>
<br/>

# Deploying to AWS ECS using Terraform
This example creates an ECS cluster and deploys the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) to it and provisions it with the required secrets using the [SecretHub AWS Identity Provider](https://secrethub.io/docs/reference/aws/).

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed along with the [SecretHub Provider](https://secrethub.io/docs/guides/terraform/#install)
1. Correctly configured [AWS Credentials](https://www.terraform.io/docs/providers/aws/index.html#authentication)
1. [Values assigned](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables) to the variables in [variables.tf](./variables.tf)

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

Get the public IP of the cluster from the AWS console or using the AWS CLI and visit `http://<PUBLIC-IP>:8080` to see the app running.
