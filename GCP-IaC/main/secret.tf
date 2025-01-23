#Cloud SQL DB user password
resource "google_secret_manager_secret" "cloud_sql_db_user_pass" {
  project   = var.security_project_id
  secret_id = "secret-cloudsql-db-pass"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "europe-west1"
      }
    }
  }
}
resource "google_secret_manager_secret" "cloud_sql_db_user_name" {
  project   = var.security_project_id
  secret_id = "secret-cloudsql-db-username"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "europe-west1"
      }
    }
  }
}

resource "google_secret_manager_secret" "sendgrid_api_key" {
  project   = var.security_project_id
  secret_id = "sendgrid-api-key"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "europe-west1"
      }
    }
  }
}

resource "google_secret_manager_secret" "billing_account" {
  project   = var.security_project_id
  secret_id = "billing-account"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "europe-west1"
      }
    }
  }
}
