resource "google_compute_firewall" "fw-allow-external-ssh-to-bastion" {
  project = var.project
  name    = "allow-external-ssh-to-bastion"
  network = var.network

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw-allow-internal-ssh" {
  project = var.project
  name    = "allow-internal-ssh"
  network = var.network

  direction          = "INGRESS"
  source_tags        = ["bastion"]
  destination_ranges = ["10.128.0.0/9"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw-allow-internal-icmp" {
  project = var.project
  name    = "allow-icmp"
  network = var.network

  direction          = "INGRESS"
  source_tags        = ["bastion"]
  destination_ranges = ["10.128.0.0/9"]

  allow {
    protocol = "icmp"
  }
}