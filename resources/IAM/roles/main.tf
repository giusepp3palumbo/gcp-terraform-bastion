# roles/resourcemanager.projectIamAdmin
resource "google_project_iam_member" "binding" {
  project = var.project
  role    = var.role
  member  = var.member
}