#Resourse Project Infrastructure
resource "google_project" "iac-security-proj-prod" {
  name            = "iac-security-proj-prod"
  project_id      = "iac-security-proj-prod"
  billing_account = data.google_secret_manager_secret_version.billing_account.secret_data
  folder_id       = google_folder.security.id
}

# Enabling the CRM API
resource "google_project_service" "iac-security-proj-prod-crm-service" {
  project                    = google_project.iac-security-proj-prod.id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

# Enabling the Services and APIs
resource "google_project_service" "iac-securit-proj-services" {
  count                      = length(var.iac-security-proj-prod-services)
  project                    = var.service_project_id
  service                    = var.iac-security-proj-prod-services[count.index]
  disable_dependent_services = true
}