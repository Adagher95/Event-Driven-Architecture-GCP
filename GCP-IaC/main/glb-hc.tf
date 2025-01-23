# Health Check Load Balncer 
resource "google_compute_health_check" "health_check_glb" {
  name    = "hc-tcp-8888-${var.service_project_id}-glb"
  project = var.service_project_id

  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port = "80"
    request_path = "/"
  
  }
}

# Health Check IGM
resource "google_compute_health_check" "health_check_igm" {
  name    = "hc-tcp-80-${var.service_project_id}-igm"
  project = var.service_project_id

  timeout_sec         = 15
  check_interval_sec  = 15
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port = "80"
    request_path = "/"  
  }
}
