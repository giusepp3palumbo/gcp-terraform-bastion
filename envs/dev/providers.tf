terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      configuration_aliases = [
        google.europe-west6,
        google.europe-west6-a,
        google.europe-west6-b
      ]
    }
  }
}
