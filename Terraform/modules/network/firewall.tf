resource "google_compute_firewall" "vm-rules" {
  project = var.project
  name    = "allow-ssh"
  network = google_compute_network.mynetwork.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["management-vm"]
}

 