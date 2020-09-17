provider "google" {
  project = var.gcp_project_id
}

data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  name     = var.gke_cluster
  location = var.gke_cluster_location
}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${data.google_container_cluster.cluster.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

terraform {
  required_providers {
    secrethub = {
      source = "secrethub/secrethub"
      version = "~> 1.2.3"
    }
  }
}

resource "google_kms_key_ring" "secrethub" {
  name     = "secrethub"
  location = "global"
}
