locals {
  machine_type_bastion_host = "f1-micro"
  machine_type_web_server   = "f1-micro"
  machine_type_db           = "f1-micro"
}


# REGIONAL NETWORK LAYER (SUBNET)
module "subnet-europe-west6" {
  providers = {
    google.dst = google.provider-europe-west6
  }
  source  = "../../../resources/VPC/subnet"
  network = var.network_id
  cidr    = var.cidr
}

# COMPUTE LAYER
module "dev_instances_europe_west6_a" {
  providers = {
    google.dst = google.provider-europe-west6-a
  }
  source                    = "../../../resources/GCE/instances"
  environment               = var.environment
  network                   = var.network_id
  subnet                    = module.subnet-europe-west6.subnet_id
  tag_vm_type_key_id        = var.tag_vm_type_key_id
  tag_vm_type_value_id      = var.tag_vm_type_value_id
  template_id               = var.bastion_template_id
  machine_type_bastion_host = local.machine_type_bastion_host
  machine_type_web_server   = local.machine_type_web_server
}

module "dev_instances_europe_west6_b" {
  providers = {
    google.dst = google.provider-europe-west6-b
  }
  source                    = "../../../resources/GCE/instances"
  environment               = var.environment
  network                   = var.network_id
  subnet                    = module.subnet-europe-west6.subnet_id
  tag_vm_type_key_id        = var.tag_vm_type_key_id
  tag_vm_type_value_id      = var.tag_vm_type_value_id
  template_id               = var.webserver_template_id
  machine_type_bastion_host = local.machine_type_bastion_host
  machine_type_web_server   = local.machine_type_web_server
}
