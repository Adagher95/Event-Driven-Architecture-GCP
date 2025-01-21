output "app_1_public_url" {
  value = google_compute_managed_ssl_certificate.lb_1_cert.managed[0].domains[0]
}
