#Resourse Project Infrastructure
resource "google_project" "iac-infra-proj-prod" {
  name            = "iac-infra-proj-prod"
  project_id      = "iac-infra-proj-prod"
  billing_account = data.google_secret_manager_secret_version.billing_account.secret_data
  folder_id       = google_folder.infrastructure.id
}

# Enabling the CRM API
resource "google_project_service" "iac-infra-proj-prod-crm-service" {
  project                    = google_project.iac-infra-proj-prod.id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

# Enabling the Services and APIs
resource "google_project_service" "iac-infra-proj-services" {
  count                      = length(var.iac-infra-proj-prod-services)
  project                    = var.service_project_id
  service                    = var.iac-infra-proj-prod-services[count.index]
  disable_dependent_services = true
}

# Budget & Alerts
resource "google_billing_budget" "iac-infra-proj-prod_budget" {
  billing_account = data.google_secret_manager_secret_version.billing_account.secret_data
  display_name    = "Billing Budget Infra-Project"

  budget_filter {
    projects = ["projects/${var.service_project_number}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = "130"
    }
  }

  threshold_rules {
    threshold_percent = 0.25
  }

  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 0.75
  }

  threshold_rules {
    threshold_percent = 1.0
  }
  threshold_rules {
    threshold_percent = 0.9
    spend_basis       = "FORECASTED_SPEND"
  }

  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.iac-infra-proj-prod-notification-channel_1.id,
      google_monitoring_notification_channel.iac-infra-proj-prod-notification-channel_2.id
    ]
    disable_default_iam_recipients = true
  }
}

resource "google_monitoring_notification_channel" "iac-infra-proj-prod-notification-channel_1" {
  display_name = "Ahmad Dagher"
  type         = "email"

  labels = {
    email_address = "ahmad95dagher@gmail.com"
  }
}

resource "google_monitoring_notification_channel" "iac-infra-proj-prod-notification-channel_2" {
  display_name = "Org. Admin"
  type         = "email"

  labels = {
    email_address = "ahmad_gcp@ahmadd71.com"
  }
}