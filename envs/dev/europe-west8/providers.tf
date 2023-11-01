provider "google" {
  alias   = "provider-europe-west8"
  region  = "europe-west8"
  project = var.project
}

provider "google" {
  alias   = "provider-europe-west8-a"
  region  = "europe-west8"
  zone    = "europe-west8-a"
  project = var.project
}

provider "google" {
  alias   = "provider-europe-west8-b"
  region  = "europe-west8"
  zone    = "europe-west8-b"
  project = var.project
}
