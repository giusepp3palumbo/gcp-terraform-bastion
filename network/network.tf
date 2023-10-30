resource "google_compute_network" "vpc_network" {
  provider = google.dst
  name                    = var.network_name
  auto_create_subnetworks = false
}