resource "google_compute_instance_template" "bastion_template" {
  project      = var.project
  name         = "${var.environment}-bastion-template"
  machine_type = var.machine_type_bastion_host

  tags = [var.environment, "bastion"] // network tags

  labels = {
    environment = var.environment
    vm-type     = "bastion"
  }

  scheduling {
    automatic_restart = true
  }

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  service_account {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }

  network_interface {
    network = "default"
  }
}

resource "google_compute_instance_template" "webserver_template" {
  project      = var.project
  name         = "webserver-template"
  machine_type = var.machine_type_web_server

  tags = [var.environment, "web"]

  labels = {
    environment = var.environment
    vm-type     = "web"
  }

  scheduling {
    automatic_restart = true
  }

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }
}