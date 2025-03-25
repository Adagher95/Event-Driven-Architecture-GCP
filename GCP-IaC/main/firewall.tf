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
    ports = ["8080",
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

resource "google_compute_firewall" "allow_cloud_sql_access" {
  name      = "allow-cloud-sql-access"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "192.168.16.0/20"
  ]
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_http" {
  name      = "allow-http"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "192.168.16.0/20"
  ]
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

resource "google_compute_firewall" "allow_http_ingress" {
  name      = "allow-http-ingress"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "0.0.0.0/0"
  ]
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "30080"]
  }
}

resource "google_compute_firewall" "allow_internal_access" {
  name      = "allow-internal-access"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "192.168.16.0/20"
  ]
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

resource "google_compute_firewall" "allow_internal_access_usw" {
  name      = "allow-internal-access-usw"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "172.24.10.0/24"
  ]
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

resource "google_compute_firewall" "allow_lb_to_instances" {
  name      = "allow-lb-to-instances"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "0.0.0.0/0"
  ]
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

resource "google_compute_firewall" "allow_lb_traffic" {
  name      = "allow-lb-traffic"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "0.0.0.0/0"
  ]
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "30080"]
  }
}

resource "google_compute_firewall" "allow_nodeport" {
  name      = "allow-nodeport"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "0.0.0.0/0"
  ]
  allow {
    protocol = "tcp"
    ports    = ["30080", "8080", "80"]
  }
}



resource "google_compute_firewall" "allow_ssh" {
  name      = "allow-ssh"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "0.0.0.0/0"
  ]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw_allow_health_checks_tcp" {
  name      = "fw-allow-health-checks-tcp"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }
}

resource "google_compute_firewall" "fw_allow_iap_tcp" {
  name      = "fw-allow-iap-tcp"
  network   = var.host_network
  project   = var.host_project_id
  direction = "INGRESS"
  priority  = 1000
  disabled  = false
  source_ranges = [
    "35.235.240.0/20"
  ]
  target_tags = ["iap"]
  allow {
    protocol = "tcp"
    ports    = ["22", "3389", "3306"]
  }
}
