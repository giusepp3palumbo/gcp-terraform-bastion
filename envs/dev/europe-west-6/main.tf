
# REGIONAL NETWORK LAYER (SUBNET)
module "subnet-europe-west6" {
  providers = {
    google.dst = google.europe-west6
  }
  source  = "../../../resources/subnet"
  network = var.network_id
  cidr    = var.cidr
}

# COMPUTE LAYER
module "dev_instances_europe_west6_a" {
  providers = {
    google.dst = google.europe-west6-a
  }
  source               = "../../../resources/GCE/instances"
  environment          = var.environment
  network              = var.network_id
  subnet               = module.subnet-europe-west6.subnet_id
  tag_vm_type_key_id   = var.tag_vm_type_key_id
  tag_vm_type_value_id = var.tag_vm_type_value_id
  template_id = var.bastion_template_id
}

module "dev_instances_europe_west6_b" {
  providers = {
    google.dst = google.europe-west6-b
  }
  source               = "../../../resources/GCE/instances"
  environment          = var.environment
  network              = var.network_id
  subnet               = module.subnet-europe-west6.subnet_id
  tag_vm_type_key_id   = var.tag_vm_type_key_id
  tag_vm_type_value_id = var.tag_vm_type_value_id
  template_id = var.webserver_template_id
}
