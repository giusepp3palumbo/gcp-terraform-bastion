module "dev_env_europe_west6_a" {
  source = "./envs/dev"
  cidr   = var.cidr
  providers = {
    google.dst  = google.europe-west6-a
  }
}


# module "prod-env" {
#   source = "./envs/prod"
# }
