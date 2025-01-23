# Data block for the DB password to use for the user in the Cloud SQL instance
data "google_secret_manager_secret_version" "cloud_sql_db_user_pass_var" {
  project = var.security_project_id
  secret  = google_secret_manager_secret.cloud_sql_db_user_pass.id
}

data "google_secret_manager_secret_version" "cloud_sql_db_user_name_var" {
  project = var.security_project_id
  secret  = google_secret_manager_secret.cloud_sql_db_user_name.id
}

data "google_secret_manager_secret_version" "sendgrid_api_key" {
  project = var.security_project_id
  secret  = google_secret_manager_secret.sendgrid_api_key.id
}

data "google_secret_manager_secret_version" "billing_account" {
  project = var.security_project_id
  secret  = google_secret_manager_secret.billing_account.id
}