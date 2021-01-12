# SecretHub + EKS

This example uses Terraform to deploy the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) on a EKS cluster and provision it with the secrets it needs using the [SecretHub AWS Identity Provider](https://secrethub.io/docs/reference/aws/). 

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed along with the [SecretHub Provider](https://secrethub.io/docs/guides/terraform/#install)
1. Correctly configured [AWS Credentials](https://www.terraform.io/docs/providers/aws/index.html#authentication)
1. [Values assigned](https://www.terraform.io/docs/configuration/variables.html#assigning-values-to-root-module-variables) to the variables in [variables.tf](./variables.tf)

## Running the example

To deploy the app on your cluster, run:
```
terraform init
terraform apply
```

After launching it, forward the port to your local machine using `kubectl`:

```
kubectl port-forward deployment/demo-app 8080
```

To see the app running, visit [http://127.0.0.1:8080](http://127.0.0.1:8080).
