# Internal VPC traffic for Business App 1 VMs
resource "google_compute_firewall" "internal_fw" {
  name        = "fw-allow-local-tcp"
  project     = var.host_project_id
  network     = var.host_network
  description = "Firewall rule to allow internal traffic between the VMs"

  direction = "INGRESS"

  source_ranges = [
    "${var.subnet_ip_range[0]}",
    "${var.subnet_ip_range[1]}"
  ]


  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

}

# GCP health checks firewall rule
resource "google_compute_firewall" "health_checks_fw" {
  name        = "fw-allow-health-checks-tcp"
  project     = var.host_project_id
  network     = var.host_network
  description = "Firewall rule to allow the GCP health checks to reach the VMs"

  direction = "INGRESS"

  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]


  allow {
    protocol = "tcp"
    ports    = ["8080",
               "80",
               "443"
               ]
  }

}

# GCP IAP IP ranges
resource "google_compute_firewall" "app_iap_fw" {
  name        = "fw-allow-iap-tcp"
  project     = var.host_project_id
  network     = var.host_network
  description = "Firewall rule to allow the GCP IAP IP range to reach the VMs"

  direction = "INGRESS"

  source_ranges = [
    "35.235.240.0/20"
  ]

  target_tags = ["iap"]

  allow {
    protocol = "tcp"
    ports = [
      "22",
      "3389",
      "3306"
    ]
  }
}