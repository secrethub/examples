variable "gcp_project_id" {
  description = "GCP project ID"
}

variable "gcp_zone" {
  description = "GCP zone to run Compute instance in"
}

variable "secrethub_repo" {
  description = "SecretHub repo that contains the demo `username` and `password` secrets"
}

provider "google" {
  project = var.gcp_project_id
}

provider "secrethub" {}

resource "google_kms_key_ring" "secrethub" {
  name     = "secrethub"
  location = "global"
}
