

module "mynetwork" {
  providers = {
    google.dst = google.europe-west6
  }
  source       = "../../network"
  network_name = "devnetwork"
}

module "subnet-swiss" {
  providers = {
    google.dst = google.europe-west6
  }
  source      = "../../subnet"
  network     = module.mynetwork.network_id
  subnet_name = "svizzera"
  cidr        = var.cidr
}

module "firewall" {
  providers = {
    google.dst = google.europe-west6
  }
  source      = "../../firewall"
  network     = module.mynetwork.network_id
  cidr        = var.cidr
}

module "web_server_dev_a" {
  providers = {
    google.dst = google.europe-west6-a
  }
  source       = "../../instance"
  name         = "web-server-dev-a"
  machine_type = "f1-micro"
  network      = module.mynetwork.network_id
  subnet      = module.subnet-swiss.subnet_id
}

module "web_server_dev_b" {
  providers = {
    google.dst = google.europe-west6-b
  }
  source       = "../../instance"
  name         = "web-server-dev-b"
  machine_type = "f1-micro"
  network      = module.mynetwork.network_id
  subnet      = module.subnet-swiss.subnet_id
}

# module "db_server" {
#   source       = "../../instance"
#   name = "db-server-dev"
#   machine_type = "f1-micro"
#   network = "devnetwork"
# }