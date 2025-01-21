# A host project provides network resources to associated service projects.

resource "google_compute_shared_vpc_host_project" "host_project" {
  project = var.host_project_id
}

# A service project gains access to network resources provided by its
# associated host project.
resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = var.host_project_id
  service_project = var.service_project_id
}


resource "google_compute_subnetwork_iam_member" "member_1" {
  project    = var.host_project_id
  region     = var.gcp_region_1
  subnetwork = google_compute_subnetwork.subnet1.id
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.service_project_number}@cloudservices.gserviceaccount.com"

}

resource "google_compute_subnetwork_iam_member" "member_2" {
  project    = var.host_project_id
  region     = var.gcp_region_2
  subnetwork = google_compute_subnetwork.subnet2.id
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.service_project_number}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "member_3" {
  project    = var.host_project_id
  region     = var.gcp_region_1
  subnetwork = google_compute_subnetwork.regional_proxy_subnet.id
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.service_project_number}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "member_4" {
  project    = var.host_project_id
  region     = var.gcp_region_1
  subnetwork = google_compute_subnetwork.subnet1.id
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${var.service_project_number}@compute-system.iam.gserviceaccount.com"

}


resource "google_compute_subnetwork_iam_member" "member_5" {
  project    = var.host_project_id
  region     = var.gcp_region_2
  subnetwork = google_compute_subnetwork.subnet2.id
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${var.service_project_number}@compute-system.iam.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "member_6" {
  project    = var.host_project_id
  region     = var.gcp_region_1
  subnetwork = google_compute_subnetwork.subnet1.id
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${var.service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "gke_sql_client" {
  project = var.service_project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.service_project_number}@cloudservices.gserviceaccount.com"
}

resource "google_pubsub_topic_iam_binding" "pubsub_trigger_permission" {
  project = var.service_project_id
  topic   = google_pubsub_topic.user_submit_topic.name

  role    = "roles/pubsub.subscriber"
  members = [
    "serviceAccount:service-${var.service_project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  ]
}

