resource "aws_iam_role" "demo_app" {
  name               = "SecretHubDemoEKSRole"
  description        = "Role for SecretHub demo app"
  assume_role_policy = data.aws_iam_policy_document.demo_app_assume_role.json
}

resource "kubernetes_service_account" "demo_app" {
  automount_service_account_token = true
  metadata {
    name = "demo-app"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.demo_app.arn
    }
  }
}

data "aws_iam_policy_document" "demo_app_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["${aws_iam_openid_connect_provider.cluster.arn}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(local.oidc_issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:demo-app"]
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

resource "aws_iam_role_policy_attachment" "demo_app_secrethub" {
  role       = aws_iam_role.demo_app.name
  policy_arn = aws_iam_policy.secrethub_auth.arn
}

resource "secrethub_service_aws" "demo_app" {
  repo        = var.secrethub_repo
  role        = aws_iam_role.demo_app.name
  kms_key_arn = aws_kms_key.secrethub_auth.arn
}

resource "secrethub_access_rule" "demo_app" {
  account_name = secrethub_service_aws.demo_app.id
  dir          = var.secrethub_repo
  permission   = "read"
}

resource "kubernetes_deployment" "demo_app" {
  metadata {
    name = "demo-app"
    labels = {
      run = "demo-app"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        run = "demo-app"
      }
    }
    template {
      metadata {
        labels = {
          run = "demo-app"
        }
      }
      spec {
        service_account_name            = kubernetes_service_account.demo_app.metadata[0].name
        automount_service_account_token = true

        container {
          image = "secrethub/demo-app"
          name  = "demo-app"
          port {
            container_port = 8080
          }
          env {
            name  = "SECRETHUB_IDENTITY_PROVIDER"
            value = "aws"
          }
          env {
            name  = "DEMO_USERNAME"
            value = "secrethub://${var.secrethub_repo}/username"
          }
          env {
            name  = "DEMO_PASSWORD"
            value = "secrethub://${var.secrethub_repo}/password"
          }
        }
      }
    }
  }

  wait_for_rollout = false
  depends_on = [
    secrethub_access_rule.demo_app,
  ]
}
