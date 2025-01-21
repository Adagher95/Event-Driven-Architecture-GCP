project_id = "terraform-core-project"
credentials_file = "Credentials\\Creds.json"
gcp_region = "us-west1"
gcp_zone = "us-west1-a"
organization_id = "410699974645" 
billing_account = "01D257-D34288-8AFA4D"

gcp_region_1 = "us-central1"
gcp_region_2 = "us-west1"
gcp_region_3 = "me-central1"
gcp_region_4 = "us-east1"

gcp_zone_1 = "us-central1-a"
gcp_zone_3 = "me-central1-a"

host_project_id    = "iac-network-proj-prod"
service_project_id = "iac-infra-proj-prod"

host_project_number = "694603014208"
service_project_number = "568331077048"

vpc_auto_create_subnets = false

vpc_mtu = 1460

subnet_ip_range = [
  "192.168.16.0/20",  # IP range for us-central1
  "172.24.10.0/24",   # IP range for us-west1
  "10.1.0.0/24",   # IP range for me-central1
  "10.2.0.0/24"  # IP range for us-east1
]

sub1_cidr       = "192.168.16.0/20" # IP range for us-central1
sub2_cidr       = "172.24.10.0/24" # IP range for us-west1
sub3_cidr       = "10.1.0.0/24" # IP range for me-central1 
sub4_cidr       = "10.2.0.0/24" # IP range for us-east1 



proxy_sub1_cidr = "192.168.1.0/24"
proxy_sub2_cidr = "192.168.1.0/24"


pod_cidr1    = "10.244.0.0/16"
pod_cidr2    = "10.245.0.0/16"
service_cidr1 = "172.32.0.0/28"
service_cidr2 = "10.0.33.0/28"
service-cidr = "10.34.0.0/16"

source_ip_ranges = "12.55.11.45/32"

host_network = "projects/iac-network-proj-prod/global/networks/vpc-iac-network-proj-prod-0"

host_subnet_1 = "projects/iac-network-proj-prod/regions/us-central1/subnetworks/subnet-iac-network-proj-prod-usc1"

host_subnet_2 = "projects/iac-network-proj-prod/regions/us-west1/subnetworks/subnet-iac-network-proj-prod-usw1"

host_subnet_3 = "projects/iac-network-proj-prod/regions/me-central1/subnetworks/subnet-iac-network-proj-prod-mec1"

host_subnet_4 = "projects/iac-network-proj-prod/regions/us-east1/subnetworks/subnet-iac-network-proj-prod-use1"



iac-network-proj-prod-services = [
  "compute.googleapis.com",
  "servicenetworking.googleapis.com",
  "billingbudgets.googleapis.com",
  "container.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "iam.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com"
]

iac-infra-proj-prod-services = [
  "compute.googleapis.com",
  "sql-component.googleapis.com",
  "sqladmin.googleapis.com",
  "servicenetworking.googleapis.com",
  "iap.googleapis.com",
  "secretmanager.googleapis.com",
  "billingbudgets.googleapis.com",
  "container.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "iam.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com",
  "artifactregistry.googleapis.com",
  "cloudbuild.googleapis.com",
  "cloudtrace.googleapis.com",
  "oslogin.googleapis.com",
  "pubsub.googleapis.com",
  "cloudfunctions.googleapis.com"
  ]

gke_cluster_1_name = "app-cluster"

gke_cluster_2_name = "management-cluster"


gke_cluster_1_node_pool_name = "app-cluster-node-pool"

gke_cluster_2_node_pool_name = "management-cluster-node-pool"


node_config_1 = {
  machine_type = "e2-medium" 
  disk_size_gb = "20"         
  disk_type    = "pd-standard"
}

node_config_2 = {
  machine_type = "e2-medium" 
  disk_size_gb = "20"         
  disk_type    = "pd-standard"
}

gke_cluster_1_initial_nodes = "1"

gke_cluster_2_initial_nodes = "1"

gke_cluster_1_autoscaling = {
  min_node_count = "1"   
  max_node_count = "2"
}

gke_cluster_2_autoscaling = {
  min_node_count = "1"   
  max_node_count = "2"
}

clusters_identity_namespace = {
  workload_pool = "iac-infra-proj-prod.svc.id.goog"
}

app_name = "flask-app"

mysql_instance = {
  cloud_sql_name               = "app-sql"
  instance_tier                = "db-f1-micro"
  instance_disk_type           = "PD_HDD"
  instance_disk_size           = 10
  instance_disk_autoresize     = false
  instance_availability_type   = "ZONAL"
  instance_ipv4_enabled        = false
  instance_deletion_protection = false
  app_name = "web-app"
}

pubsub_topic_name = "user-submit-topic"
pubsub_subscription_name = "user-submit-subscription"

cloud_function_name ="Email-Confirmation"
sendgrid_api_key = "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"
entry_point = "send_email"

named_ports = {
  app = {
    port_name   = "flask-app"
    port_number = 30080
  }
}

github_owner = "Adagher95"
github_repo = "Event-Driven-Architecture-GCP"

cloud_build_trigger = "flask-app-trigger"
gcp_location = "global"

cloudbuild_trigger_file = "./cloudbuild.yaml"