resource "google_compute_instance" "my_vm" {
  provider     = google.dst
  name         = var.name
  machine_type = var.machine_type
  # zone         = "infered"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        env  = var.label_vm_env
        type = var.label_vm_type
      }
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet

    dynamic "access_config" {
      for_each = var.ext_ip ? [""] : []
      content {

      }
    }
  }

  service_account {
    email = var.sa_email
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}