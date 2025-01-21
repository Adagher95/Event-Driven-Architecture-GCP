provider "google" {
  project     = "terraform-state-proj"
  credentials = file("Credentials\\Creds.json")
  region      = "us-east1"
  zone = "us-east1-a"
}
