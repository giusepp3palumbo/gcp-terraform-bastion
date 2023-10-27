resource "google_service_account" "bastian_host_dev_sa" {
  provider     = google.dst
  account_id   = "bastian-host-dev-sa"
  display_name = "Service Account for dev VM"
}