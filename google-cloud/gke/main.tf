variable "gcp_project_id" {
  description = "GCP project ID"
}

variable "gke_cluster" {
  description = "Name of your GKE cluster, must be in `gcp_location`"
}

variable "gke_cluster_location" {
  description = "GCP location where the `gke_cluster` runs"
}

variable "secrethub_repo" {
  description = "SecretHub repo that contains the demo `username` and `password` secrets"
}

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

provider "secrethub" {}

resource "google_kms_key_ring" "secrethub" {
  name     = "secrethub"
  location = "global"
}
