data "google_client_config" "current" {
  provider = google.dst
}


resource "google_compute_subnetwork" "subnet" {
  provider = google.dst
  network  = var.network
  name     = var.subnet_name
  # region        = data.google_client_config.current.region
  ip_cidr_range = var.cidr[data.google_client_config.current.region]
}
