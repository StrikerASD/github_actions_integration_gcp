resource "google_project_service" "wif_api" {
  for_each = toset([
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    "cloudkms.googleapis.com",
    "container.googleapis.com",
    "run.googleapis.com"
  ])
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}