output "cidr-management-subnet" {
  value = google_compute_subnetwork.management-subnet.ip_cidr_range
}

output "network-id" {
  value = google_compute_network.mynetwork.id
}
output "workload-subnet-id" {
  value = google_compute_subnetwork.workload-subnet.id
}
output "management-subnet-id" {
  value = google_compute_subnetwork.management-subnet.id
}