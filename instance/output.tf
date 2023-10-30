output "bastion_host_ip" {
  value = google_compute_instance_from_template.bastion_host.network_interface.0.network_ip
}

output "web_server_ip" {
  value = google_compute_instance_from_template.web-server.network_interface.0.network_ip
}