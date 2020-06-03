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

To launch an example EC2 instance (`t2.nano`), run:
```
terraform init
terraform apply
```

When the instance is fully up and running, connect to it, and install the SecretHub CLI:
```
sudo curl https://yum.secrethub.io/secrethub.repo --output /etc/yum/repos.d/secrethub.repo --create-dirs
sudo yum install -y secrethub-cli
```

Next, provision the app with secrets by referencing them in environment variables.
These will automatically be replaced with the corresponding secret values.
```
export DEMO_USERNAME=secrethub://<your-username>/demo/username
export DEMO_PASSWORD=secrethub://<your-username>/demo/password
```

Finally, run the app with the `secrethub run` command
```
secrethub run --identity-provider=aws -- secrethub demo serve --host 0.0.0.0 --port 8080
```

To see the app running, visit `http://<EC2-INSTANCE-IP>:8080`.
