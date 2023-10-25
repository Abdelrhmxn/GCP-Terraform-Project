resource "google_compute_network" "mynetwork" {
  name                    = "project-network"
  auto_create_subnetworks = false
} 