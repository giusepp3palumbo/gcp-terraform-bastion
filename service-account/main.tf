resource "google_service_account" "bastion_host_dev_sa" {
  provider     = google.dst
  account_id   = "bastion-host-dev-sa"
  display_name = "Service Account for dev VM"
}