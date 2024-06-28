# terragrunt.hcl

# Configure Terragrunt to use a specific Terraform version
terraform {
  required_version = ">= 0.14.9"

  # Use a local backend for storing Terraform state
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Include all configurations from child Terragrunt files
include {
  path = "environments/*"
}