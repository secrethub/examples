resource "aws_kms_key" "secrethub" {
  description = "KMS key for ${var.role_name} SecretHub authentication"
}

data "aws_iam_policy_document" "secrethub_auth" {
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["${aws_kms_key.secrethub.arn}"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "secrethub_auth" {
  name        = "SecretHubAuth-${var.role_name}"
  description = "Allow SecretHub service authentication using KMS"
  policy      = "${data.aws_iam_policy_document.secrethub_auth.json}"
}

resource "aws_iam_role_policy_attachment" "role_secrethub_auth" {
  role       = "${var.role_name}"
  policy_arn = "${aws_iam_policy.secrethub_auth.arn}"
}

resource "secrethub_service_aws" "example_app" {
  repo    = "${var.repo_path}"
  role    = "${var.role_name}"
  kms_key = "${aws_kms_key.secrethub.arn}"
}

resource "secrethub_access_rule" "example_app" {
  count = "${length(var.access_rules)}"

  account_name = "${secrethub_service_aws.example_app.id}"
  dir_path     = "${element(keys(var.access_rules), count.index)}"
  permission   = "${lookup(var.access_rules, element(keys(var.access_rules), count.index))}"
}
