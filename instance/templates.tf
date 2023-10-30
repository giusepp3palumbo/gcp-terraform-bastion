locals {
  machine_type_bastion_host = "f1-micro"
  machine_type_web_server = "f1-micro"
  machine_type_db = "f1-micro"
}

data "google_client_config" "current" {
  provider = google.dst
}

resource "google_compute_instance_template" "bastion_template" {
  provider = google.dst

  name        = "bastion-template"
  machine_type         = local.machine_type_bastion_host

  tags = [var.environment, "bastion"] // network tags

  labels = {
    environment = var.environment
    vm-type = "bastion"
  }

  scheduling {
    automatic_restart   = true
  }

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet

    access_config {
      // Ephemeral public IP
    }
  }
  
  service_account {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_template" "webserver_template" {
  provider = google.dst
  name        = "webserver-template"
  machine_type         = local.machine_type_web_server

  tags = [var.environment, "web"]

  labels = {
    environment = var.environment
    vm-type = "web"
  }

  scheduling {
    automatic_restart   = true
  }

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet

    access_config {
      // Ephemeral public IP
    }
  }
}