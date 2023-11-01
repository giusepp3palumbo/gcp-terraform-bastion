locals {
  environment = "dev"
}

# SERVICE ACCOUNT FOR BASTION
module "bastion_host_sa_dev" {
  project = var.project
  source  = "../../resources/IAM/service-account"
}

# IAM ROLES FOR BASTIONS'S SERVICE ACCOUNT
module "bastion_host_iam1_dev" {
  project = var.project
  source  = "../../resources/IAM/roles"
  role    = "roles/compute.osLogin"
  member  = format("serviceAccount:%s", module.bastion_host_sa_dev.sa_email)
}

module "bastion_host_iam2_dev" {
  project = var.project
  source  = "../../resources/IAM/roles"
  role    = "roles/batch.serviceAgent"
  member  = format("serviceAccount:%s", module.bastion_host_sa_dev.sa_email)
}

# TAGS
resource "google_tags_tag_key" "tag_vm_type_key" {
  parent     = "projects/${var.project}"
  short_name = "vm-type"
}

resource "google_tags_tag_value" "tag_vm_type_value" {
  parent     = "tagKeys/${google_tags_tag_key.tag_vm_type_key.name}"
  short_name = "bastion"
}

# GLOBAL NETWORK LAYER (VPC)
module "network_dev" {
  project      = var.project
  source       = "../../resources/VPC/network"
  network_name = "devnetwork"
}

# Instance Template"
module "dev_instances_template" {
  project     = var.project
  source      = "../../resources/GCE/templates"
  environment = local.environment
  sa_email    = module.bastion_host_sa_dev.sa_email
}

# REGIONAL SETUP FOR europe-west6"
module "europe_west6" {
  project               = var.project
  source                = "./europe-west6"
  environment           = local.environment
  network_id            = module.network_dev.network_id
  sa_email              = module.bastion_host_sa_dev.sa_email
  tag_vm_type_key_id    = google_tags_tag_key.tag_vm_type_key.name
  tag_vm_type_value_id  = google_tags_tag_value.tag_vm_type_value.name
  cidr                  = var.cidr
  bastion_template_id   = module.dev_instances_template.bastion_template_id
  webserver_template_id = module.dev_instances_template.webserver_template_id
}

# REGIONAL SETUP FOR europe-west8"
module "europe_west8" {
  project               = var.project
  source                = "./europe-west8"
  environment           = local.environment
  network_id            = module.network_dev.network_id
  sa_email              = module.bastion_host_sa_dev.sa_email
  tag_vm_type_key_id    = google_tags_tag_key.tag_vm_type_key.name
  tag_vm_type_value_id  = google_tags_tag_value.tag_vm_type_value.name
  cidr                  = var.cidr
  bastion_template_id   = module.dev_instances_template.bastion_template_id
  webserver_template_id = module.dev_instances_template.webserver_template_id
}

# google_compute_instance_template.webserver_template.self_link_unique / google_compute_instance_template.bastion_template.self_link_unique

# OPEN FIREWALL RULES
module "firewall_rules" {
  project = var.project
  source  = "../../resources/VPC/firewall"
  network = module.network_dev.network_id
}

