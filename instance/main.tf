resource "google_compute_instance" "vm-micro" {
  name         = var.name
  machine_type = var.machine_type
  zone         = "europe-west6-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = var.network

    access_config {
      // Ephemeral public IP
    }
  }

  allow_stopping_for_update = true
}