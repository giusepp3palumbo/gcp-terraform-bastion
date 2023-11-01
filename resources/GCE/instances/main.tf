data "google_client_config" "current" {
  provider = google.dst
}



resource "google_compute_instance_from_template" "bastion_host" {
  provider                 = google.dst
  name                     = "${var.environment}-bastion-${data.google_client_config.current.region}"
  source_instance_template = var.template_id
  machine_type             = var.machine_type_bastion_host

  params {
    resource_manager_tags = {
      "tagKeys/${var.tag_vm_type_key_id}" = "tagValues/${var.tag_vm_type_value_id}"
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnet

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_compute_instance_from_template" "web-server" {
  provider                 = google.dst
  name                     = "${var.environment}-webserver-${data.google_client_config.current.region}"
  source_instance_template = var.template_id
  machine_type             = var.machine_type_web_server
}
