variable "secrethub_username" {
  description = "Your SecretHub username"
}

variable "repo_name" {
  description = "The name of the repo for which to create the service account"
}

resource "secrethub_service" "demo_service_account" {
  repo = "${var.secrethub_username}/${var.repo_name}"
}

resource "secrethub_access_rule" "demo_access_rule" {
  account_name = secrethub_service.demo_service_account.id
  dir          = "${var.secrethub_username}/${var.repo_name}"
  permission   = "read"
}

output "service_credential" {
  value     = secrethub_service.demo_service_account.credential
  sensitive = true
}
