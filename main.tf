# Service account associated with workload identity pool
resource "google_service_account" "github-svc" {
  project      = "sb-izal-20240910-144605"
  account_id   = "gcp-github-access"
  display_name = "Service Account - github-svc"
}

resource "google_project_iam_member" "github-access" {

  project = "sb-izal-20240910-144605"
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github-svc.email}"
}