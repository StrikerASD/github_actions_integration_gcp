module "gh_oidc" {
  source            = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version           = "4.0.0"
  project_id        = var.project_id
  pool_id           = "gh-identity-pool"
  pool_display_name = "Identity Pool"
  provider_id       = "gh-provider"
  sa_mapping = {
    (google_service_account.github-svc.account_id) = {
      sa_name   = google_service_account.github-svc.name
      #attribute = "*"
      attribute = "attribute.repository_owner/StrikerASD"
    }
  }
  attribute_mapping = {
    "google.subject"            = "assertion.sub"
    "attribute.actor"           = "assertion.actor"
    "attribute.aud"             = "assertion.aud"
    "attribute.repository"      = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "assertion.repository_owner=='StrikerASD'"
}