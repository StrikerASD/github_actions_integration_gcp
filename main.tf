# Service account associated with workload identity pool
resource "google_service_account" "github-svc" {
  project      = var.project_id
  account_id   = "gcp-github-access"
  display_name = "Service Account - github-svc"
}

resource "google_project_iam_member" "github-access" {

  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github-svc.email}"
}