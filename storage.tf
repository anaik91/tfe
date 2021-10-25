resource "google_storage_bucket" "bucket1" {
  name          = "auto-expiring-bucket-987654"
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket" "bucket2" {
  name          = "auto-expiring-bucket-98765432"
  location      = "US"
  force_destroy = true
  encryption {
    default_kms_key_name = google_kms_crypto_key.crypto_key.id
  }
}

resource "google_storage_bucket" "auto-expire" {
  name          = "auto-expiring-bucket"
  location      = "US"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 3
      num_newer_versions = 2
    }
    action {
      type = "Delete"
    }
  }
}