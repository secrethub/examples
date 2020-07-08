<p align="center">
  <img src="https://secrethub.io/img/integrations/gce/github-banner.png?v1" alt="GCE + SecretHub" height="230">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/docs/guides/gce/"><img alt="View Docs" src="https://secrethub.io/img/buttons/github/view-docs.png?v2" height="28" /></a>
</p>
<br/>

This example uses Terraform to launch an Google Compute instance, deploy the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) on it and provision it with the secrets it needs using the [SecretHub GCP Identity Provider](https://secrethub.io/docs/reference/gcp/). 

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed along with the [SecretHub Provider](https://secrethub.io/docs/guides/terraform/#install)
1. Correctly configured [GCP Credentials](https://www.terraform.io/docs/providers/google/guides/provider_reference.html#full-reference)
1. Variables in [variables.tf](./variables.tf)

## Running the example

Init the SecretHub demo repo with example values
```
secrethub demo init
```

To launch a Compute instance (`n1-standard-1`) that runs the demo app, run:
```
terraform init
terraform apply
```

Once the instance is running its public IP will be outputted.

To see the app running, visit `http://<COMPUTE-INSTANCE-IP>:8080`.
