# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host_project" {
  project = var.host_project_id
}

# A service project gains access to network resources provided by its associated host project.
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

  role = "roles/pubsub.subscriber"
  members = [
    "serviceAccount:service-${var.service_project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  ]
}

resource "google_project_iam_member" "artifact_registry_admin" {
  project = var.service_project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:github@${var.service_project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "artifact_registry_create_on_push_writer" {
  project = var.service_project_id
  role    = "roles/artifactregistry.createOnPushWriter"
  member  = "serviceAccount:github@${var.service_project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.service_project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:pubsub-app-sa@${var.service_project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_binding" "artifact_registry_reader_with_condition" {
  project = var.service_project_id
  role    = "roles/artifactregistry.reader"

  members = [
    "serviceAccount:github@${var.service_project_id}.iam.gserviceaccount.com"
  ]

  condition {
    title      = "cloudbuild-connection-setup"
    expression = "request.time < timestamp(\"2025-01-20T21:45:11.064Z\")"
  }
}

resource "google_project_iam_member" "artifact_registry_service_agent" {
  project = var.service_project_id
  role    = "roles/artifactregistry.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-artifactregistry.iam.gserviceaccount.com"
}

resource "google_project_iam_binding" "artifact_registry_writer_with_condition" {
  project = var.service_project_id
  role    = "roles/artifactregistry.writer"

  members = [
    "serviceAccount:github@${var.service_project_id}.iam.gserviceaccount.com"
  ]
}

resource "google_project_iam_member" "cloudbuild_builder" {
  project = var.service_project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${var.service_project_number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_service_agent" {
  project = var.service_project_id
  role    = "roles/cloudbuild.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "clouddeploy_service_agent" {
  project = var.service_project_id
  role    = "roles/clouddeploy.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-clouddeploy.iam.gserviceaccount.com"
}


resource "google_project_iam_member" "cloudfunctions_service_agent" {
  project = var.service_project_id
  role    = "roles/cloudfunctions.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcf-admin-robot.iam.gserviceaccount.com"
}



resource "google_project_iam_member" "compute_network_viewer" {
  project = var.service_project_id
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${var.service_project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]"
}

resource "google_project_iam_member" "compute_service_agent" {
  project = var.service_project_id
  role    = "roles/compute.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@compute-system.iam.gserviceaccount.com"
}


resource "google_project_iam_member" "container_admin" {
  project = var.service_project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${var.service_project_number}-compute@developer.gserviceaccount.com"
}



resource "google_project_iam_member" "container_service_agent" {
  project = var.service_project_id
  role    = "roles/container.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@container-engine-robot.iam.gserviceaccount.com"
}




resource "google_project_iam_member" "gkehub_service_agent" {
  project = var.service_project_id
  role    = "roles/gkehub.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-gkehub.iam.gserviceaccount.com"
}


resource "google_project_iam_member" "multiclusteringress_service_agent" {
  project = var.service_project_id
  role    = "roles/multiclusteringress.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-multiclusteringress.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "multiclustermetering_service_agent" {
  project = var.service_project_id
  role    = "roles/multiclustermetering.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-mcmetering.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "multiclusterservicediscovery_service_agent" {
  project = var.service_project_id
  role    = "roles/multiclusterservicediscovery.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-mcsd.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "pubsub_service_agent" {
  project = var.service_project_id
  role    = "roles/pubsub.serviceAgent"
  member  = "serviceAccount:service-${var.service_project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}


