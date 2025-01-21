# App Cluster Configuration 
resource "google_container_cluster" "app_cluster" {
  name               = var.gke_cluster_1_name
  location           = var.gcp_region_1
  initial_node_count = var.gke_cluster_1_initial_nodes
  project            = google_project.iac-infra-proj-prod.project_id
  network            = var.host_network
  subnetwork         = var.host_subnet_1
  
  remove_default_node_pool = true

  deletion_protection = false

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-cidr1"
    services_secondary_range_name = "service-cidr1"
  }

  
  

  workload_identity_config {
  workload_pool = var.clusters_identity_namespace.workload_pool
}
}

# Management Cluster Configuration 
resource "google_container_cluster" "management_cluster" {
  name               = var.gke_cluster_2_name
  location           = var.gcp_region_2
  initial_node_count = var.gke_cluster_2_initial_nodes
  project            = google_project.iac-infra-proj-prod.project_id
  network            = var.host_network
  subnetwork         = var.host_subnet_2
  remove_default_node_pool = true

  deletion_protection = false

  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-cidr2"
    services_secondary_range_name = "service-cidr2"
  }

  workload_identity_config {
  workload_pool = var.clusters_identity_namespace.workload_pool
}
}


