output "network_id" {
  value = module.mynetwork.network_id
}

output "project" {
  value = module.subnet-swiss.project
}

output "bastian_host_ip" {
  value = module.bastian_host_dev.vm_ip
}