

module "mynetwork" {
  providers = {
    google.dst = google.europe-west6
  }
  source       = "../../network"
  network_name = "devnetwork"
}

module "subnet-svizzera" {
  providers = {
    google.dst = google.europe-west6
  }
  source      = "../../subnet"
  network     = module.mynetwork.network_id
  subnet_name = "svizzera"
  cidr        = var.cidr
}

# module "web_server" {
#   source       = "../../instance"
#   name = "web-server-dev"
#   machine_type = "f1-micro"
#   network = "devnetwork"
# }

# module "db_server" {
#   source       = "../../instance"
#   name = "db-server-dev"
#   machine_type = "f1-micro"
#   network = "devnetwork"
# }