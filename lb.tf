resource "google_compute_forwarding_rule" "default1" {
  name                  = "website-forwarding-rule1"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend.id
  all_ports             = true
  allow_global_access   = true
  network               = google_compute_network.default.name
  subnetwork            = google_compute_subnetwork.default.name
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
}

resource "google_compute_forwarding_rule" "default2" {
  name                  = "website-forwarding-rule2"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.backend.id
  allow_global_access   = true
  network               = google_compute_network.default.name
  subnetwork            = google_compute_subnetwork.default.name
}

resource "google_compute_region_backend_service" "backend" {
  name                  = "website-backend"
  region                = "us-central1"
  health_checks         = [google_compute_health_check.hc.id]
}
resource "google_compute_health_check" "hc" {
  name               = "check-website-backend"
  check_interval_sec = 1
  timeout_sec        = 1
  tcp_health_check {
    port = "80"
  }
}
resource "google_compute_network" "default" {
  name = "website-net"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "default" {
  name          = "website-net"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.default.id
}

resource "google_compute_region_backend_service" "backend_no_hc" {
  name                  = "website-backend"
  region                = "us-central1"
}