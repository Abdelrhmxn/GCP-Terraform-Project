resource "google_container_cluster" "abdelrhmxn-gke-cluster" {
  name                     = "abdelrhmxn-gke-cluster"
  location                 = var.gke-location
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network-id
  subnetwork               = var.workload-subnet-id
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    master_global_access_config {
      enabled = true
    }
  }
  ip_allocation_policy {
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/16"
      display_name = "Management Subnet"
    }
  }
  
}
 

resource "google_container_node_pool" "abdelrhmxn-node-pool" {
  name       = "abdelrhmxn-node-pool"
  location   = google_container_cluster.abdelrhmxn-gke-cluster.location
  cluster    = google_container_cluster.abdelrhmxn-gke-cluster.name
  node_count = 1
  node_config {
    preemptible     = true
    machine_type    = var.type-vm
    service_account = var.cluster-serviceaccount
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 40
  }


}
