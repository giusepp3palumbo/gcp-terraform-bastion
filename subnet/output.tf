output "project" {
  value = data.google_client_config.current.project
}

output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}