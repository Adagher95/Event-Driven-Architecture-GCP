resource "google_storage_bucket" "default" {
  name          = "${var.project_id}-bucket-state"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

# Enabling the CRM API
resource "google_project_service" "terraform-core-project-crm-service" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

# Enabling the remaining APIs and services
resource "google_project_service" "terraform-core-project-services" {
  count = length(var.terraform-core-project-services)
  project = var.project_id
  service = var.terraform-core-project-services[count.index]
  disable_dependent_services = true
}