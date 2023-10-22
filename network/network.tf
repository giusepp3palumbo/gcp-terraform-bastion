data "google_client_config" "current" {}

resource "google_compute_network" "vpc_network" {
  #project                 = data.google_client_config.current.project
  provider                = google.dst
  name                    = var.network_name
  auto_create_subnetworks = false
}