terraform {
  backend "gcs" {
    bucket = "terraform-core-project-bucket-state"
    prefix = "core/state"
    credentials = "Credentials\\Creds.json"

  }
}