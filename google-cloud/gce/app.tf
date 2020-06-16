resource "google_service_account" "demo_app" {
  account_id  = "demo-app"
  description = "SecretHub demo app"
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

resource "google_compute_instance" "demo_app" {
  name         = "secrethub-demo"
  machine_type = "n1-standard-1"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      // Image with Docker pre-installed
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_firewall.demo_app.network

    access_config {
      // Auto-assign IP
    }
  }

  metadata_startup_script = <<EOT
    docker run -p 8080:8080 \
      -e DEMO_USERNAME=secrethub://${var.secrethub_repo}/username \
      -e DEMO_PASSWORD=secrethub://${var.secrethub_repo}/password \
      -e SECRETHUB_IDENTITY_PROVIDER=gcp \
      secrethub/demo-app
  EOT

  service_account {
    email = google_service_account.demo_app.email
    scopes = ["https://www.googleapis.com/auth/cloudkms"]
  }

  allow_stopping_for_update = true

  depends_on = [
    secrethub_access_rule.demo_app,
  ]
}

resource "google_compute_firewall" "demo_app" {
  name    = "allow-demo-app"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

output "public_ip" {
  value = google_compute_instance.demo_app.network_interface[0].access_config[0].nat_ip
}
