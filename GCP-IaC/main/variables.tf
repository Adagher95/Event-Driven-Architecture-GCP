variable "project_id" {
    type = string
    description = "The project ID that I will be working with"
}

variable "credentials_file" {
    type = string
    description = "The JSON credential file to be used within the provider.tf file"
}

variable "gcp_region" {
    type = string
    description = "The primary GCP region to deploy the resources"
    default = "us-west1"
}

variable "gcp_zone" {
    type = string
    description = "The primary GCP zone within the region to be used"
    default = "us-west1-a"
}

variable "organization_id" {
  type        = string
  description = "The value of the organization ID"
}

variable "billing_account" {
  type        = string
  description = "The ID of the billing account that I will be using for this environment"
}

variable "host_project_id" {
  description = "Project in which GCP Resources Shared VPC to be created"
  type        = string
}

variable "service_project_id" {
  description = "Project in which is linked to the Shared VPC"
  type        = string
}

variable "host_project_number" {
  description = "The Host project number"
  type        = string
}

variable "service_project_number" {
  description = "The Service Project number"
  type        = string
}

variable "gcp_region_1" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

variable "gcp_zone_1" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

variable "gcp_zone_3" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

variable "gcp_region_2" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

variable "gcp_region_3" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

variable "gcp_region_4" {
  description = "Region in which GCP Resources to be created"
  type        = string
}
variable "iac-infra-proj-prod-services" {
  type        = list(string)
  description = "The list of the services that we want to enable in the GCP project"
}

variable "iac-network-proj-prod-services" {
  type        = list(string)
  description = "The list of the services that we want to enable in the GCP project"
}

variable "sub1_cidr" {
  description = "Us Central1 Region Subnet CIDR range"
  type        = string
}

variable "sub2_cidr" {
  description = "Us East1 Region Region Subnet CIDR range"
  type        = string
}

variable "sub3_cidr" {
  description = "Me Central1 Region Region Subnet CIDR range"
  type        = string
}

variable "sub4_cidr" {
  description = "US East1 Region Region Subnet CIDR range"
  type        = string
}

variable "proxy_sub1_cidr" {
  description = "US Central1 Region in which Loadbalancer to be created"
  type        = string
}


variable "proxy_sub2_cidr" {
  description = "US East1 Region in which GCP Resources to be created"
  type        = string
}

variable "pod_cidr1" {
  description = "The pod-1 CIDR range"
  type        = string
}

variable "pod_cidr2" {
  description = "The pod-2 CIDR range"
  type        = string
}

variable "service_cidr1" {
  description = "The Service1 CIDR range"
  type        = string
}

variable "service_cidr2" {
  description = "The Service2 CIDR range"
  type        = string
}

variable "service-cidr" {
  description = "US Central1 Region in which GCP Resources to be created"
  type        = string
}

variable "source_ip_ranges" {
  description = "Source IP Address"
  type        = string
}

variable "subnet_ip_range" {
  type        = list(string)
  description = "The list of IPv4 CIDR ranges to be used in the VPC that will be created"
}

variable "vpc_auto_create_subnets" {
  type        = bool
  description = "Defines the behavior for the VPC whether we want to use it in auto mode (true) or a custom VPC (false)"
  default     = false
}

variable "vpc_mtu" {
  type        = number
  description = "The value of the MTU for our new VPC"
  default     = 1460
}

variable "host_network" {
  type        = string
  description = "The value of the Shared VPC name"
}

variable "host_subnet_1" {
  type        = string
  description = "The value of the us-central1 subnet name"
}


variable "host_subnet_2" {
  type        = string
  description = "The value of the us-west1 subnet name"
}


variable "host_subnet_3" {
  type        = string
  description = "The value of the me-central1 subnet name"
}


variable "host_subnet_4" {
  type        = string
  description = "The value of the us-east1 subnet name"
}


variable "gke_cluster_1_name" {
  type        = string
  description = "The value of the App cluster name"
}

variable "gke_cluster_2_name" {
  type        = string
  description = "The value of the Management cluster name"
}

 
variable "gke_cluster_1_node_pool_name" {
  type        = string
  description = "The value of the App cluster node pool name"
}

variable "gke_cluster_2_node_pool_name" {
  type        = string
  description = "The value of the Management cluster node pool name"
}

variable "use_ip_aliases" {
  description = "Whether to use IP aliases for the GKE clusters"
  type        = bool
  default     = true
}

variable "node_config_1" {
  description = "The app cluster nodes configuration values and properties"
  type = object(
    {
      machine_type          = string
      disk_size_gb    = number
      disk_type           = string
    }
  )
}

variable "node_config_2" {
  description = "The management cluster nodes configuration values and properties"
  type = object(
    {
      machine_type          = string
      disk_size_gb    = number
      disk_type           = string
    }
  )
}

variable "gke_cluster_1_initial_nodes" {
  type        = number
  description = "The Starting number of node per zone for the app cluster"
}

variable "gke_cluster_2_initial_nodes" {
  type        = number
  description = "The Starting number of node per zone for the management cluster"
}

variable "gke_cluster_1_autoscaling" {
  description = "The Autoscaling configuration values of node per zone for the app cluster"
  type        = object(
    {
      min_node_count = number   
      max_node_count = number  
    }
  )
}

variable "gke_cluster_2_autoscaling" {
  description = "The Autoscaling configuration values of node per zone for the management cluster"
  type        = object(
    {
      min_node_count = number   
      max_node_count = number   
    }
  )
}

variable "clusters_identity_namespace" {
  description = "The Workload Identity namespace for the GKE clusters"
  type = object({
    workload_pool = string
  })
}


variable "mysql_instance" {
  description = "The Cloud SQL instance configuration values and properties"
  type = object(
    {
      cloud_sql_name               = string
      instance_tier                = string
      instance_disk_type           = string
      instance_disk_size           = number
      instance_disk_autoresize     = bool
      instance_availability_type   = string
      instance_ipv4_enabled        = bool
      instance_deletion_protection = bool
      app_name                     = string
    }
  )
}


variable "pubsub_topic_name" {
  type = string
  description = "the Cloud Pub/Sub Topic name"
}

variable "pubsub_subscription_name" {
  type = string
  description = "the Cloud Pub/Sub Subsicription name"
}

variable "cloud_function_name" {
  description = "Name of the Cloud Function"
  type        = string
  default     = "email-cloud-function"
}

variable "sendgrid_api_key" {
  type = string
  description = "The API key"
}

variable "entry_point" {
  type = string
  description = "The Entry point for the cloud function"
}

variable "named_ports" {
  type = object({
    app = object({
      port_name   = string
      port_number = number
    })
  })
}


variable "app_name" {
  type        = string
  description = "The value of the App name"
}

variable "github_owner" {
  description = "GitHub username or organization"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}


variable "cloud_build_trigger" {
  description = "The Cloud Build Trigger name"
  type        = string
}

variable "gcp_location" {
  description = "The Cloud Build location"
  type        = string
}

variable "cloudbuild_trigger_file" {
  type        = string
  description = "The cloud build trigger file location"
}