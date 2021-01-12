variable "secrethub_repo" {
  description = "SecretHub repo that contains the demo `username` and `password` secrets. To create this repo, run `secrethub demo init`."
}

variable "vpc_id" {
  description = "The VPC the EKS cluster lives in."
}

variable "subnets" {
  type        = list(string)
  description = "The subnets the EKS cluster lives in. A minimum of 2 AZs is required."
}
