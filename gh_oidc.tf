module "gh_oidc" {
  source            = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version           = "v3.1.1"
  project_id        = "sb-izal-20240910-144605"
  pool_id           = "gh-identity-pool"
  pool_display_name = "Identity Pool"
  provider_id       = "gh-provider"
  sa_mapping = {
    (google_service_account.github-svc.account_id) = {
      sa_name   = google_service_account.github-svc.name
      attribute = "*"
    }
  }
}