variable "gcp_project_id" {
  description = "GCP project ID."
}

variable "gke_cluster" {
  description = "Name of your GKE cluster, must be in `gcp_location`."
}

variable "gke_cluster_location" {
  description = "GCP location where the `gke_cluster` runs."
}

variable "secrethub_repo" {
  description = "SecretHub repo that contains the demo `username` and `password` secrets. To create the repo, run `secrethub demo init`."
}
