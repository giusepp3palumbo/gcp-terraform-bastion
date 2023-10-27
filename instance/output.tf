output "vm_ip" {
  value = google_compute_instance.my_vm.network_interface.0.network_ip
}

output "vm_name" {
  value = google_compute_instance.my_vm.name
}