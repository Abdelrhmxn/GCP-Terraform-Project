resource "google_compute_instance" "management-vm" {
  name                      = "management-vm"
  machine_type              = var.type-vm
  zone                      = var.zone-vm
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = var.image-vm
    }
  }

  network_interface {
    network    = var.network-id
    subnetwork = var.management-subnet-id
  }
  tags = ["management-vm"]

  service_account {
    email  = var.vm-service_account
    scopes = ["cloud-platform"]
  }

}


 