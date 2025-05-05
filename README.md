GitHub Actions Integration with Google Cloud Platform (GCP)
This repository demonstrates how to securely integrate GitHub Actions with Google Cloud Platform (GCP) using Workload Identity Federation (WIF). By leveraging OpenID Connect (OIDC), this setup allows GitHub Actions workflows to authenticate to GCP without the need for long-lived service account keys, enhancing security and simplifying credential management.


Repository Structure
.github/workflows/: Contains GitHub Actions workflow files.

enable_apis.tf: Terraform script to enable necessary GCP APIs.

gh_oidc.tf: Terraform configuration for setting up Workload Identity Federation between GitHub and GCP.

main.tf: Main Terraform configuration file.

terraform.tfvars: Variables file for Terraform configurations.

variables.tf: Defines input variables for Terraform.

Getting Started
Prerequisites
A GCP project with billing enabled.

Terraform installed on your local machine.

GitHub repository where you want to set up the integration.

Steps
Clone the Repository

git clone https://github.com/StrikerASD/github_actions_integration_gcp.git
cd github_actions_integration_gcp
Configure Terraform Variables

Edit the terraform.tfvars file to include your GCP project details:

project_id = "your-gcp-project-id"
workload_identity_pool_id = "your-identity-pool-id"
workload_identity_provider_id = "your-identity-provider-id"
github_repository = "owner/repository"
Initialize and Apply Terraform Configuration


terraform init
terraform apply
This will set up the necessary resources in GCP, including enabling required APIs and configuring Workload Identity Federation.

Configure GitHub Repository

In your GitHub repository, navigate to Settings > Secrets and variables > Actions, and add the following secrets:

GCP_PROJECT: Your GCP project ID.

WORKLOAD_IDENTITY_PROVIDER: The full identifier of the Workload Identity Provider, e.g., projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider.

SERVICE_ACCOUNT_EMAIL: The email of the GCP service account to impersonate.

Set Up GitHub Actions Workflow

Create a workflow file in .github/workflows/, for example, deploy.yml:

name: Deploy to GCP

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: 'read'
      id-token: 'write'

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Authenticate to GCP
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: ${{ secrets.WORKLOAD_IDENTITY_PROVIDER }}
          service_account: ${{ secrets.SERVICE_ACCOUNT_EMAIL }}

      - name: Set up Cloud SDK
        uses: google-github-actions/setup-gcloud@v1
        with:
          project_id: ${{ secrets.GCP_PROJECT }}

      - name: Deploy Application
        run: |
          # Add your deployment commands here
          echo "Deploying application to GCP..."
This workflow checks out your code, authenticates to GCP using Workload Identity Federation, sets up the Cloud SDK, and runs your deployment commands.

Security Considerations
Workload Identity Federation eliminates the need to store long-lived service account keys in GitHub, reducing the risk of credential leakage.

Ensure that the GCP service account has the minimum required permissions for your workflows.

Regularly review and audit permissions and access controls in both GCP and GitHub.

Resources
GitHub Actions Documentation

Google Cloud Workload Identity Federation

License
This project is licensed under the MIT License.
