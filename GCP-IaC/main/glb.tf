# Global IP Address for the app
resource "google_compute_global_address" "glb_ext_ip" {
  name    = "ip-ext-${var.service_project_id}"
  project = var.service_project_id
}

# Managed SSL certificate
resource "google_compute_managed_ssl_certificate" "lb_1_cert" {
  name    = "cert-${var.service_project_id}"
  project = var.service_project_id

  managed {
    domains = [
      "${google_compute_global_address.glb_ext_ip.address}.nip.io"
    ]
  }
}


# The backend services
resource "google_compute_backend_service" "app_backend_service" {
  name                  = "app-backend-service"
  project               = var.service_project_id
  health_checks         = [google_compute_health_check.health_check_glb.id]
  port_name             = var.named_ports.app.port_name
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30
  protocol              = "HTTP"


  # Backend for gke-app-cluster node pools
  backend {
    group           = "projects/${var.service_project_id}/zones/us-central1-a/instanceGroups/gke-app-cluster-app-cluster-node-pool-7aa23b93-grp"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 0.8
  }

  backend {
    group           = "projects/${var.service_project_id}/zones/us-central1-b/instanceGroups/gke-app-cluster-app-cluster-node-pool-f895708d-grp"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 0.8
  }

  backend {
    group           = "projects/${var.service_project_id}/zones/us-central1-c/instanceGroups/gke-app-cluster-app-cluster-node-pool-1d00657d-grp"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 0.8
  }

  # Backend for gke-management-clust node pools
  backend {
    group           = "projects/${var.service_project_id}/zones/us-west1-a/instanceGroups/gke-management-clust-management-clust-d6c7db7b-grp"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 0.8
  }

  backend {
    group           = "projects/${var.service_project_id}/zones/us-west1-b/instanceGroups/gke-management-clust-management-clust-7537400a-grp"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 0.8
  }

  backend {
    group           = "projects/${var.service_project_id}/zones/us-west1-c/instanceGroups/gke-management-clust-management-clust-5a22573e-grp"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 0.8
  }

  #security_policy = google_compute_security_policy.cloud_armor_owasp.name

  depends_on = [
    google_compute_health_check.health_check_glb
  ]
}


# URL map config
resource "google_compute_url_map" "app_url_map" {
  name    = "url-map-${var.service_project_id}"
  project = var.service_project_id

  default_service = google_compute_backend_service.app_backend_service.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.app_backend_service.id

    path_rule {
      paths   = ["/"]
      service = google_compute_backend_service.app_backend_service.id
    }
  }
}


# Target proxy
resource "google_compute_target_https_proxy" "app_https_target_proxy" {
  name             = "target-proxy-https-${var.service_project_id}"
  project          = var.service_project_id
  url_map          = google_compute_url_map.app_url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.lb_1_cert.id]

}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name                  = "gfwr-${var.service_project_id}"
  project               = var.service_project_id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_https_proxy.app_https_target_proxy.id
  port_range            = 80
  ip_address            = google_compute_global_address.glb_ext_ip.id


}