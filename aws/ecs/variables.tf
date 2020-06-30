variable "secrethub_repo" {
  description = "Your SecretHub repository"
}

variable "vpc_id" {}

variable "subnets" {
  type = list(string)
}
