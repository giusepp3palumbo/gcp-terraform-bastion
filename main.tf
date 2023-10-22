

module "dev-env" {
  source = "./envs/dev"
  cidr   = var.cidr
  providers = {
    google.europe-west6   = google.europe-west6
    google.europe-west6-a = google.europe-west6-a
    google.europe-west6-b = google.europe-west6-b
  }
}



# module "prod-env" {
#   source = "./envs/prod"
# }
