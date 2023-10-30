provider "google" {
  alias   = "europe-west6-a"
  region  = "europe-west6"
  zone    = "europe-west6-a"
  project = var.project
}

provider "google" {
  alias   = "europe-west6-b"
  region  = "europe-west6"
  zone    = "europe-west6-b"
  project = var.project
}
