output "service_credential" {
  value     = secrethub_service.demo_service_account.credential
  sensitive = true
}

output "secret_path" {
  value     = secrethub_secret.test_secret.path
  sensitive = false
}
