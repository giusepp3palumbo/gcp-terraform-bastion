

output "bastion_template_id" {
  value = google_compute_instance_template.bastion_template.self_link_unique
}

output "webserver_template_id" {
  value = google_compute_instance_template.webserver_template.self_link_unique
}