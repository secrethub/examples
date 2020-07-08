<p align="center">
  <img src="https://secrethub.io/img/integrations/gke/github-banner.png?v1" alt="GKE + SecretHub" height="230">
</p>
<br/>

<p align="center">
  <a href="https://secrethub.io/docs/guides/gke/"><img alt="View Docs" src="https://secrethub.io/img/buttons/github/view-docs.png?v2" height="28" /></a>
</p>
<br/>

This example uses Terraform to deploy the [SecretHub Demo App](https://secrethub.io/docs/start/getting-started/#consume) on a GKE cluster and provision it with the secrets it needs using the [SecretHub GCP Identity Provider](https://secrethub.io/docs/reference/gcp/). 

## Prerequisites
1. [Terraform](https://www.terraform.io/downloads.html) installed along with the [SecretHub Provider](https://secrethub.io/docs/guides/terraform/#install)
1. Correctly configured [GCP Credentials](https://www.terraform.io/docs/providers/google/guides/provider_reference.html#full-reference)
1. Variables in [variables.tf](./variables.tf)

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
