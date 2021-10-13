resource "google_dataproc_cluster" "mycluster_kkms" {
  provider                      = google-beta
  name                          = "mycluster"
  region                        = "us-central1"
  graceful_decommission_timeout = "120s"

  labels = {
    gcp_region           = "US"
    owner                = "hybridenv"
    application_division = "pci"
    application_name     = "demo"
    application_role     = "app"
    environment          = "dev"
    au                   = "0223092"
    data_confidentiality = "pub"
    data_compliance      = "pci"
    data_type            = "test"
    created              = "YYYYMMDD"
  }

  cluster_config {
    staging_bucket = "dataproc-staging-bucket"

    master_config {
      num_instances = 1
      machine_type  = "e2-medium"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "e2-medium"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      tags = ["foo", "bar"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      # service_account = google_service_account.default.email
      service_account_scopes = [
        "cloud-platform"
      ]
    }

    # You can define multiple initialization_action blocks
    initialization_action {
      script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
      timeout_sec = 500
    }

    endpoint_config {
      enable_http_port_access = "true"
    }

    encryption_config {
      kms_key_name = "projects/projectId/locations/region/keyRings/keyRingName/cryptoKeys/keyName"
    }

  }
}

resource "google_dataproc_cluster" "mycluster_ukms" {
  provider                      = google-beta
  name                          = "mycluster"
  region                        = "us-central1"
  graceful_decommission_timeout = "120s"

  labels = {
    gcp_region           = "US"
    owner                = "hybridenv"
    application_division = "pci"
    application_name     = "demo"
    application_role     = "app"
    environment          = "dev"
    au                   = "0223092"
    data_confidentiality = "pub"
    data_compliance      = "pci"
    data_type            = "test"
    created              = "YYYYMMDD"
  }

  cluster_config {
    staging_bucket = "dataproc-staging-bucket"

    master_config {
      num_instances = 1
      machine_type  = "e2-medium"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "e2-medium"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      tags = ["foo", "bar"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      service_account = "somesa@saome.com"
      service_account_scopes = [
        "cloud-platform"
      ]
    }

    # You can define multiple initialization_action blocks
    initialization_action {
      script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
      timeout_sec = 500
    }

    endpoint_config {
      enable_http_port_access = "true"
    }

    encryption_config {
      kms_key_name = google_kms_crypto_key.crypto_key.id
    }

  }
}

resource "google_dataproc_cluster" "mycluster" {
  provider                      = google-beta
  name                          = "mycluster"
  region                        = "us-central1"
  graceful_decommission_timeout = "120s"

  labels = {
    gcp_region           = "US"
    owner                = "hybridenv"
    application_division = "pci"
    application_name     = "demo"
    application_role     = "app"
    environment          = "dev"
    au                   = "0223092"
    data_confidentiality = "pub"
    data_compliance      = "pci"
    data_type            = "test"
    created              = "YYYYMMDD"
  }

  cluster_config {
    staging_bucket = "dataproc-staging-bucket"

    master_config {
      num_instances = 1
      machine_type  = "e2-medium"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "e2-medium"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.3.7-deb9"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      tags = ["foo", "bar"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      service_account = google_service_account.default.email
      service_account_scopes = [
        "cloud-platform"
      ]
    }

    # You can define multiple initialization_action blocks
    initialization_action {
      script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
      timeout_sec = 500
    }

    endpoint_config {
      enable_http_port_access = "true"
    }

  }
}