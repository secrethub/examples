provider "google" {
  project = var.gcp_project_id
}

provider "secrethub" {}

resource "google_kms_key_ring" "secrethub" {
  name     = "secrethub"
  location = "global"
}
