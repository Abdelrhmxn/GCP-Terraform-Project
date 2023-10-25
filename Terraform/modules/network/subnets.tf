resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  ip_cidr_range = var.cidr-management-subnet
  region        = var.region-management-subnet
  network       = google_compute_network.mynetwork.id
}

resource "google_compute_subnetwork" "workload-subnet" {
  name          = "workload-subnet"
  ip_cidr_range = var.cidr-workload-subnet
  region        = var.region-workload-subnet
  network       = google_compute_network.mynetwork.id
}


# Region1 ---> us-central1 ---> for GKE
# Region2 ---> us-east1 ---> for private-vm 