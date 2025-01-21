# Google Cloud Storage Bucket
resource "google_storage_bucket" "cloud_function_bkt" {
  name          = "cloud-fun-${var.service_project_id}-src-bkt"
  force_destroy = false
  location      = "US"
  project = var.service_project_id
}

resource "google_storage_bucket_object" "source_code" {
  name   = "src-function"
  source = "cloud-function-source.zip"
  bucket = google_storage_bucket.cloud_function_bkt.name
}

# Google Cloud Function 
resource "google_cloudfunctions_function" "function_cr" {
  name        = var.cloud_function_name
  runtime     = "python310"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.cloud_function_bkt.name
  source_archive_object = google_storage_bucket_object.source_code.name
  project          = var.service_project_id
  region           = var.gcp_region_1
  entry_point           = var.entry_point

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.user_submit_topic.name
  }

  environment_variables = {
    SENDGRID_API_KEY = var.sendgrid_api_key 
  }
}

