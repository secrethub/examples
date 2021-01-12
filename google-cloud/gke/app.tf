resource "google_service_account" "demo_app" {
  account_id  = "demo-app"
  description = "SecretHub demo app"
}

resource "kubernetes_service_account" "demo_app" {
  metadata {
    name = "demo-app"

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.demo_app.email
    }
  }
}

resource "google_service_account_iam_binding" "demo_app" {
  service_account_id = google_service_account.demo_app.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.gcp_project_id}.svc.id.goog[default/${kubernetes_service_account.demo_app.metadata[0].name}]",
  ]
}

resource "google_kms_crypto_key" "demo_app" {
  name     = "demo-app"
  key_ring = google_kms_key_ring.secrethub.id
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.demo_app.id
  role          = "roles/cloudkms.cryptoKeyDecrypter"

  members = [
    "serviceAccount:${google_service_account.demo_app.email}",
  ]
}

resource "secrethub_service_gcp" "demo_app" {
  repo                  = var.secrethub_repo
  service_account_email = google_service_account.demo_app.email
  kms_key_id            = google_kms_crypto_key.demo_app.id
}

resource "secrethub_access_rule" "demo_app" {
  account_name = secrethub_service_gcp.demo_app.id
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
        service_account_name = kubernetes_service_account.demo_app.metadata[0].name

        container {
          image   = "secrethub/demo-app"
          name    = "demo-app"
          command = ["demo", "serve"]
          args    = ["--host", "0.0.0.0", "--port", "8080"]
          port {
            container_port = 8080
          }
          env {
            name  = "DEMO_USERNAME"
            value = "secrethub://${var.secrethub_repo}/username"
          }
          env {
            name  = "DEMO_PASSWORD"
            value = "secrethub://${var.secrethub_repo}/password"
          }
          env {
            name  = "SECRETHUB_IDENTITY_PROVIDER"
            value = "gcp"
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
