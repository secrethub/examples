<p align="center">
  <img src="https://secrethub.io/img/integrations/aws-ec2/github-banner.png?v1" alt="AWS EC2 + SecretHub" width="390">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/docs/guides/aws-ec2/"><img alt="View Docs" src="https://secrethub.io/img/buttons/github/view-docs.png?v2" height="28" /></a>
</p>
<br/>

# Deploying to AWS EC2 using Terraform
This example launches an EC2 instance, deploys the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) on it and provisions it with the required secrets using the [SecretHub AWS Identity Provider](https://secrethub.io/docs/reference/aws/). 

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed
2. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
3. Correctly configured [AWS Credentials](https://www.terraform.io/docs/providers/aws/index.html#authentication)

## Running the example

Init the SecretHub demo repo with example values
```
secrethub demo init
```

Create an EC2 key pair by following the [AWS user guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws), if you do not have one already.

To launch an example EC2 instance (`t2.nano`), run:
```
terraform init
terraform apply
```

Once the instance is running its public IP will be outputted.

To see the app running, visit `http://<EC2-INSTANCE-IP>:8080`.

> Note that it might take a couple minutes for the instance to be accessible from the browser.