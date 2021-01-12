variable "secrethub_repo" {
  description = "SecretHub repo that contains the demo `username` and `password` secrets. To create this repo, run `secrethub demo init`."
}

variable "port" {
  description = "Port to publicly expose on the EC2 node, where the demo app will listen on."
  default     = 8080
}
