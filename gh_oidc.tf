module "gh_oidc" {
  source            = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version           = "4.0.0"
  project_id        = var.project_id
  pool_id           = "gh-identity-pool-third"
  pool_display_name = "Identity Pool"
  provider_id       = "gh-provider"
  sa_mapping = {
    (google_service_account.github-svc.account_id) = {
      sa_name   = google_service_account.github-svc.name
      #attribute = "*"
      attribute = "attribute.repository_owner/StrikerASD"
    }
  }
}