data "google_client_config" "current" {
  provider = google.dst
}


resource "google_compute_firewall" "fw-allow-external-ssh-to-bastion" {
  provider = google.dst
  name     = "allow-external-ssh-to-bastion"
  network  = var.network

  direction          = "INGRESS"
  source_ranges      = ["0.0.0.0/0"]
  target_tags = ["bastion"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw-allow-internal-ssh" {
  provider = google.dst
  name     = "allow-internal-ssh"
  network  = var.network

  direction          = "INGRESS"
  source_tags = ["bastion"]
  destination_ranges = [var.cidr[data.google_client_config.current.region], ]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}



resource "google_compute_firewall" "fw-allow-icmp" {
  provider = google.dst
  name     = "allow-icmp"
  network  = var.network

  direction     = "INGRESS"
  source_ranges = [var.cidr[data.google_client_config.current.region], ]

  allow {
    protocol = "icmp"
  }
}