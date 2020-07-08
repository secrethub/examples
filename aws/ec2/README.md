<p align="center">
  <img src="https://secrethub.io/img/integrations/aws-ec2/github-banner.png?v1" alt="AWS EC2 + SecretHub" height="230">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/docs/guides/aws-ec2/"><img alt="View Docs" src="https://secrethub.io/img/buttons/github/view-docs.png?v2" height="28" /></a>
</p>
<br/>

This example uses Terraform to launch an EC2 instance, deploy the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) on it and provision it with the required secrets using the [SecretHub AWS Identity Provider](https://secrethub.io/docs/reference/aws/). 

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed along with the [SecretHub Provider](https://secrethub.io/docs/guides/terraform/#install)
1. Correctly configured [AWS Credentials](https://www.terraform.io/docs/providers/aws/index.html#authentication)
1. Variables in [variables.tf](./variables.tf)

## Running the example

Init the SecretHub demo repo with example values
```
secrethub demo init
```

To launch an example EC2 instance (`t2.nano`), that runs the demo app, run:
```
terraform init
terraform apply
```

Once the instance is running its public IP will be outputted.

To see the app running, visit `http://<EC2-INSTANCE-IP>:8080`.

> Note that it might take a couple minutes for the instance to be accessible from the browser.
