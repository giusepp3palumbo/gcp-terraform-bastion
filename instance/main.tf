resource "google_tags_tag_key" "tag_key" {
  parent = "projects/${data.google_client_config.current.project}"
  short_name = "vm-type"
}

resource "google_tags_tag_value" "tag_value" {
    parent = "tagKeys/${google_tags_tag_key.tag_key.name}"
    short_name = "bastion"
}

resource "google_compute_instance_from_template" "bastion_host" {
  provider     = google.dst
  name         = "bastion-host-${var.environment}"
  source_instance_template = google_compute_instance_template.bastion_template.self_link_unique
  params {
    resource_manager_tags = {
      "tagKeys/${google_tags_tag_key.tag_key.name}" = "tagValues/${google_tags_tag_value.tag_value.name}"
    }
  }
}

resource "google_compute_instance_from_template" "web-server" {
  provider     = google.dst
  name         = "web-server-${var.environment}"
  source_instance_template = google_compute_instance_template.webserver_template.self_link_unique
}

# resource "google_compute_instance" "my_vm" {
#   provider     = google.dst
#   name         = var.name
#   machine_type = var.machine_type
#   # zone         = "infered"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-12"
#     }
#   }

#   network_interface {
#     network    = var.network
#     subnetwork = var.subnet

#     dynamic "access_config" {
#       for_each = var.ext_ip ? [""] : []
#       content {

#       }
#     }
#   }

#   service_account {
#     email  = var.sa_email
#     scopes = ["cloud-platform"]
#   }

#   allow_stopping_for_update = true
# }