provider "google" {
  project = var.gcp_project_id
}

terraform {
  required_providers {
    secrethub = {
      source = "secrethub/secrethub"
      version = ">= 1.2.3"
    }
  }
}

resource "google_kms_key_ring" "secrethub" {
  name     = "secrethub"
  location = "global"
}
