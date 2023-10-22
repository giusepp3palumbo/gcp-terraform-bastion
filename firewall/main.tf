data "google_client_config" "current" {
  provider     = google.dst
}


resource "google_compute_firewall" "fw-allow-ssh" {
  provider     = google.dst
  name    = "allow-ssh"
  network = var.network

  direction= "INGRESS"
  source_ranges= ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw-allow-icmp" {
  provider     = google.dst
  name    = "allow-icmp"
  network = var.network

  direction= "INGRESS"
  source_ranges= [var.cidr[data.google_client_config.current.region], ]

  allow {
    protocol = "icmp"
  }
}