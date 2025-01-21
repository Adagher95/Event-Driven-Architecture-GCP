# GKE-Cluster-1-noodpool
resource "google_container_node_pool" "app_cluster_nodes" {
  name       = var.gke_cluster_1_node_pool_name
  cluster    = google_container_cluster.app_cluster.name
  location   = google_container_cluster.app_cluster.location
  project    = google_container_cluster.app_cluster.project

  node_config {
    service_account = "pubsub-app-sa@iac-infra-proj-prod.iam.gserviceaccount.com"
    machine_type = var.node_config_1.machine_type
    disk_size_gb = var.node_config_1.disk_size_gb
    disk_type    = var.node_config_1.disk_type
    preemptible  = false 
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = var.gke_cluster_1_initial_nodes

  autoscaling {
    min_node_count = var.gke_cluster_1_autoscaling.min_node_count   
    max_node_count = var.gke_cluster_1_autoscaling.max_node_count  
  }  
}



# GKE-Cluster-2-noodpool
resource "google_container_node_pool" "management_cluster_nodes" {
  name       = var.gke_cluster_2_node_pool_name
  cluster    = google_container_cluster.management_cluster.name
  location   = google_container_cluster.management_cluster.location
  project    = google_container_cluster.management_cluster.project

  node_config {
    service_account = "pubsub-app-sa@iac-infra-proj-prod.iam.gserviceaccount.com"
    machine_type = var.node_config_2.machine_type
    disk_size_gb = var.node_config_2.disk_size_gb
    disk_type    = var.node_config_2.disk_type
    preemptible  = false 
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = var.gke_cluster_2_initial_nodes
  
  autoscaling {
    min_node_count = var.gke_cluster_2_autoscaling.min_node_count   
    max_node_count = var.gke_cluster_2_autoscaling.max_node_count  
  } 
}
