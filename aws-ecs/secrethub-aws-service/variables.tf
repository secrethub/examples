variable "role_name" {
  description = "Name of the IAM Role to attach the SecretHub auth policy to."
}

variable "repo_path" {
  description = "SecretHub repo to add the service account to."
}

variable "access_rules" {
  type        = "map"
  description = "Mapping of SecretHub directory paths and access levels to attach to the service account."
}
