provider "google" {
  alias   = "provider-europe-west6"
  region  = "europe-west6"
  project = var.project
}

provider "google" {
  alias   = "provider-europe-west6-a"
  region  = "europe-west6"
  zone    = "europe-west6-a"
  project = var.project
}

provider "google" {
  alias   = "provider-europe-west6-b"
  region  = "europe-west6"
  zone    = "europe-west6-b"
  project = var.project
}
