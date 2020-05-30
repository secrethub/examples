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

Launch the EC2 instance by running
```
terraform apply
```
and providing the requested values.

When the instance is fully up and running, connect to it, and install the SecretHub CLI:
```
sudo curl https://yum.secrethub.io/secrethub.repo --output /etc/yum/repos.d/secrethub.repo --create-dirs
sudo yum install -y secrethub-cli
```

Next, provision the app with secrets by referencing them in environment variables.
These will automatically be replaced with the secret values.
```
export DEMO_USERNAME=secrethub://<your-username>/demo/username
export DEMO_PASSWORD=secrethub://<your-username>/demo/password
```

Finally, run the app with the `secrethub run` command
```
secrethub run --identity-provider=aws -- secrethub demo serve --host 0.0.0.0 --port 8080
```

To see the app running, visit `http://<EC2-INSTANCE-IP>:8080`.
