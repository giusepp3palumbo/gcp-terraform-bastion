# NETWORK LAYER

module "network_dev" {
  providers = {
    google.dst = google.dst 
  }
  source       = "../../network"
  network_name = "devnetwork"
}

module "subnet-swiss" {
  providers = {
    google.dst = google.dst 
  }
  source      = "../../subnet"
  network     = module.network_dev.network_id
  cidr        = var.cidr
}

# SERVICE ACCOUNT

module "bastion_host_sa_dev" {
  providers = {
    google.dst = google.dst 
  }
  source = "../../service-account"
}


module "bastion_host_iam1_dev" {
  providers = {
    google.dst = google.dst 
  }
  source = "../../IAM"
  role   = "roles/compute.osLogin"
  member = format("serviceAccount:%s", module.bastion_host_sa_dev.sa_email)
}

module "bastion_host_iam2_dev" {
  providers = {
    google.dst = google.dst 
  }
  source = "../../IAM"
  role   = "roles/batch.serviceAgent"
  member = format("serviceAccount:%s", module.bastion_host_sa_dev.sa_email)
}


# COMPUTE LAYER

module "dev_instances" {
  providers = {
    google.dst = google.dst
  }
  source = "../../instance"
  environment = "dev"
  network       = module.network_dev.network_id
  subnet        = module.subnet-swiss.subnet_id
  sa_email      = module.bastion_host_sa_dev.sa_email
}


# OPEN FIREWALL RULES

module "firewall_rules" {
  providers = {
    google.dst = google.dst 
  }
  source          = "../../firewall"
  network         = module.network_dev.network_id
  cidr            = var.cidr
}