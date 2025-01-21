# VPC Network 
resource "google_compute_network" "vpc_network_prod_0" {
  project = var.host_project_id
  name    = "vpc-${var.host_project_id}-0"
  auto_create_subnetworks = var.vpc_auto_create_subnets
  mtu = var.vpc_mtu
}

# Subnet for us-central1
resource "google_compute_subnetwork" "subnet1" {
  project = var.host_project_id
  name    = "subnet-${var.host_project_id}-usc1"
  network = google_compute_network.vpc_network_prod_0.name
  region  = var.gcp_region_1
  ip_cidr_range = var.sub1_cidr
  private_ip_google_access = true

  # Secondary ranges for GKE clusters
  secondary_ip_range {
    range_name    = "pod-cidr1"
    ip_cidr_range = var.pod_cidr1
  }

  secondary_ip_range {
    range_name    = "service-cidr1"
    ip_cidr_range = var.service_cidr1
  }
}

# Subnet for us-west1 region
resource "google_compute_subnetwork" "subnet2" {
  project       = var.host_project_id
  name          = "subnet-${var.host_project_id}-usw1"
  network       = google_compute_network.vpc_network_prod_0.name
  region        = var.gcp_region_2
  ip_cidr_range = var.sub2_cidr
  private_ip_google_access = true

  # Secondary ranges for GKE clusters
  secondary_ip_range {
    range_name    = "pod-cidr2"
    ip_cidr_range = var.pod_cidr2
  }

  secondary_ip_range {
    range_name    = "service-cidr2"
    ip_cidr_range = var.service_cidr2
  }
}


# Subnet for me-central1 region
resource "google_compute_subnetwork" "subnet_3" {
  project       = var.host_project_id
  name          = "subnet-${var.host_project_id}-mec1"
  network       = google_compute_network.vpc_network_prod_0.name
  region        = var.gcp_region_3
  ip_cidr_range = var.sub3_cidr
  private_ip_google_access = true

}


# Subnet for us-east1 region
resource "google_compute_subnetwork" "subnet_4" {
  project       = var.host_project_id
  name          = "subnet-${var.host_project_id}-use1"
  network       = google_compute_network.vpc_network_prod_0.name
  region        = var.gcp_region_4
  ip_cidr_range = var.sub4_cidr
  private_ip_google_access = true


}

resource "google_compute_subnetwork" "regional_proxy_subnet" {
  project       = var.host_project_id
  name          = "ltm-${var.gcp_region_1}-regional-proxy-subnet"
  region        = var.gcp_region_1
  ip_cidr_range = var.proxy_sub1_cidr
  purpose       = "REGIONAL_MANAGED_PROXY"
  network       = google_compute_network.vpc_network_prod_0.id
  role          = "ACTIVE"
}



# Private IP range for Cloud SQL in us-central1
resource "google_compute_global_address" "cloud_sql_private_ip_range" {
  name           = "cloud-sql-ip-range"
  purpose        = "VPC_PEERING"
  address_type   = "INTERNAL"
  prefix_length  = 24
  project        = var.host_project_id
  network       = google_compute_network.vpc_network_prod_0.name


  depends_on = [
    google_compute_network.vpc_network_prod_0
    ]
}

# Private Services Connection for Cloud SQL
resource "google_service_networking_connection" "pvc_connection" {
  network                    = var.host_network
  service                    = "servicenetworking.googleapis.com"
  reserved_peering_ranges    = [
    google_compute_global_address.cloud_sql_private_ip_range.name
    ]
  depends_on = [
    google_compute_network.vpc_network_prod_0
    ]  
}

