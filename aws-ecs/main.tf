provider "aws" {
  region = "${var.region}"
}

provider "secrethub" {
  credential = "${file("~/.secrethub/credential")}"
}
