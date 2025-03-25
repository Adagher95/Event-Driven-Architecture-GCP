terraform {
  backend "gcs" {
    bucket      = "terraform-core-project-bucket-state"
    prefix      = "main-env/state"
    credentials = "Credentials\\Creds.json"

  }
}