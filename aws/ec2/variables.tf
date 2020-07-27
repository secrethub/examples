variable "secrethub_repo" {
  description = "SecretHub repo that contains the demo `username` and `password` secrets. To create the repo, run `secrethub demo init`."
}

variable "port" {
  default = 8080
}
