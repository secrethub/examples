resource "aws_iam_role" "secrethub_demo" {
  name               = "SecretHubDemoEC2Role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  description        = "Role for SecretHub demo app"
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_kms_key" "secrethub_auth" {
  description = "KMS key to facilitate SecretHub authentication"
}

data "aws_iam_policy_document" "secrethub_auth" {
  statement {
    actions   = ["kms:Decrypt"]
    resources = [aws_kms_key.secrethub_auth.arn]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "secrethub_auth" {
  name        = "SecretHubAuth"
  description = "Allow SecretHub authentication using KMS"
  policy      = data.aws_iam_policy_document.secrethub_auth.json
}

resource "aws_iam_role_policy_attachment" "secrethub_demo_auth" {
  role       = aws_iam_role.secrethub_demo.name
  policy_arn = aws_iam_policy.secrethub_auth.arn
}

resource "secrethub_service_aws" "demo_app" {
  repo        = var.secrethub_repo
  role        = aws_iam_role.secrethub_demo.name
  kms_key_arn = aws_kms_key.secrethub_auth.arn
}

resource "secrethub_access_rule" "demo_app" {
  account_name = secrethub_service_aws.demo_app.id
  dir          = var.secrethub_repo
  permission   = "read"
}

data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "secrethub_demo" {
  instance_type               = "t2.nano"
  ami                         = data.aws_ami.amazon_linux.id
  iam_instance_profile        = aws_iam_instance_profile.secrethub_demo.name
  security_groups             = [aws_security_group.secrethub_demo.name]
  associate_public_ip_address = true
  user_data = <<EOF
		#! /bin/bash
    sudo curl https://yum.secrethub.io/secrethub.repo --output /etc/yum/repos.d/secrethub.repo --create-dirs
    sudo yum install -y secrethub-cli
    export DEMO_USERNAME=secrethub://${var.secrethub_repo}/username
    export DEMO_PASSWORD=secrethub://${var.secrethub_repo}/password
    secrethub run --identity-provider=aws -- secrethub demo serve --host 0.0.0.0 --port 8080
	EOF
}

resource "aws_iam_instance_profile" "secrethub_demo" {
  role = aws_iam_role.secrethub_demo.name
}

resource "aws_security_group" "secrethub_demo" {
  description = "SecretHub demo app"

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
