locals {
  secrets_dir = "${var.secrets_repo}/${var.env}"
}

module "secrethub_example_app" {
  source = "./secrethub-aws-service"

  role_name = "${aws_iam_role.example_app.name}"
  repo_path = "${var.secrets_repo}"

  access_rules = {
    "${local.secrets_dir}" = "read"
  }
}

resource "secrethub_secret" "httpbin_bearer" {
  path = "${local.secrets_dir}/httpbin/bearer"

  generate {
    length = 20
  }
}
