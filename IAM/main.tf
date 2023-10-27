data "google_client_config" "current" {
  provider = google.dst
}

# roles/resourcemanager.projectIamAdmin
resource "google_project_iam_member" "binding" {
  project = data.google_client_config.current.project
  role     = var.role
  member   = var.member
}