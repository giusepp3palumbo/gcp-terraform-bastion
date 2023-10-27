

# NETWORK LAYER

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

# SERVICE ACCOUNT

module "bastian_host_sa_dev" {
  providers = {
    google.dst = google.europe-west6
  }
  source = "../../service-account"
}


module "bastian_host_iam1_dev" {
  providers = {
    google.dst = google.europe-west6
  }
  source = "../../IAM"
  role = "roles/compute.osLogin"
  member = format("serviceAccount:%s", module.bastian_host_sa_dev.sa_email)
}

module "bastian_host_iam2_dev" {
  providers = {
    google.dst = google.europe-west6
  }
  source = "../../IAM"
  role = "roles/batch.serviceAgent"
  member = format("serviceAccount:%s", module.bastian_host_sa_dev.sa_email)
}


# COMPUTE LAYER

module "bastian_host_dev" {
  providers = {
    google.dst = google.europe-west6-a
  }
  source          = "../../instance"
  name            = "bastian-host-dev"
  machine_type    = "f1-micro"
  network         = module.mynetwork.network_id
  subnet          = module.subnet-swiss.subnet_id
  sa_email = module.bastian_host_sa_dev.sa_email
}

module "web_server_dev_a" {
  providers = {
    google.dst = google.europe-west6-a
  }
  source          = "../../instance"
  name            = "web-server-dev-a"
  machine_type    = "f1-micro"
  network         = module.mynetwork.network_id
  subnet          = module.subnet-swiss.subnet_id
  sa_email = module.bastian_host_sa_dev.sa_email
}

# module "web_server_dev_b" {
#   providers = {
#     google.dst = google.europe-west6-b
#   }
#   source       = "../../instance"
#   name         = "web-server-dev-b"
#   machine_type = "f1-micro"
#   network      = module.mynetwork.network_id
#   subnet      = module.subnet-swiss.subnet_id
# }

# OPEN FIREWALL RULES

module "firewall_rules" {
  providers = {
    google.dst = google.europe-west6
  }
  source          = "../../firewall"
  network         = module.mynetwork.network_id
  cidr            = var.cidr
  bastian_host_ip = module.bastian_host_dev.vm_ip
}

# module "db_server" {
#   source       = "../../instance"
#   name = "db-server-dev"
#   machine_type = "f1-micro"
#   network = "devnetwork"
# }
