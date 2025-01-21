# Time sleep for 30 seconds to allow VPC peering to work
resource "time_sleep" "cloud_sql_delay_create_45s" {
  depends_on = [
    google_service_networking_connection.pvc_connection
  ]
  create_duration = "45s"
}

# Cloud SQL instance configuration
resource "google_sql_database_instance" "mysql_instance" {
  name             = var.mysql_instance.cloud_sql_name
  region           = var.gcp_region_1
  project          = var.service_project_id
  database_version = "MYSQL_8_0"


  settings {
    tier = var.mysql_instance.instance_tier

    disk_size       = var.mysql_instance.instance_disk_size
    disk_type       = var.mysql_instance.instance_disk_type
    disk_autoresize = var.mysql_instance.instance_disk_autoresize

    availability_type = var.mysql_instance.instance_availability_type

    backup_configuration {
      enabled            = true
      binary_log_enabled = true
      start_time         = "12:00"

      backup_retention_settings {
        retained_backups = 15
      }  
    }

    ip_configuration {
      ipv4_enabled                                  = var.mysql_instance.instance_ipv4_enabled
      private_network                               = var.host_network
      enable_private_path_for_google_cloud_services = true
    }

    user_labels = {
      environment    = "prod"
      app-name       = var.mysql_instance.app_name
      role           = "db"
    }

    deletion_protection_enabled = var.mysql_instance.instance_deletion_protection
    
  }

  depends_on = [
    time_sleep.cloud_sql_delay_create_45s
  ]

}   


# The app database
resource "google_sql_database" "cloud_sql_app_db" {
  name     = "${var.mysql_instance.cloud_sql_name}_prod"
  project  = var.service_project_id
  instance = google_sql_database_instance.mysql_instance.name

  depends_on = [
    google_sql_database_instance.mysql_instance
  ]
}

# The app database user
resource "google_sql_user" "cloud_sql_app_db_user" {
  name     = "ahmad-gcp"
  project  = var.service_project_id
  instance = google_sql_database_instance.mysql_instance.name
  host     = "%"
  password = "GCP-database1"

  depends_on = [
    google_sql_database_instance.mysql_instance
  ]
}


