output "network_id" {
  value = module.network_dev.network_id
}

output "project" {
  value = module.subnet-swiss.project
}

output "bastion_host_ip" {
  value = module.dev_instances.bastion_host_ip
}

output "web_server_ip" {
  value = module.dev_instances.web_server_ip
}