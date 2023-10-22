data "google_client_config" "current" {
  provider = google.dst
}


resource "google_compute_subnetwork" "subnet" {
  project       = data.google_client_config.current.project
  network       = var.network
  name          = var.subnet_name
  ip_cidr_range = var.cidr[data.google_client_config.current.region]
}
