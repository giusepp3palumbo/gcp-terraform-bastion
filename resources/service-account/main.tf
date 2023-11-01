resource "google_service_account" "bastion_host_dev_sa" {
  project      = var.project
  account_id   = "bastion-host-dev-sa"
  display_name = "Service Account for dev VM"
}