terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53"
    }
  }
}

terraform {
  backend "gcs" {
    bucket  = "<PLACEHOLDER_BUCKET>"
    prefix  = "terraform/state"
  }
}

# Create a GCS Bucket
resource "google_storage_bucket" "tf-bucket" {
  name          = local.project+"-neo4j-viz"
  location      = var.gcp_region
  force_destroy = true
  storage_class = var.storage-class
  versioning {
    enabled = true
  }
}

provider "google" {}

data "google_project" "project" {
}


locals {
  project = data.google_project.project.project_id
  service_name   = "neo4j-viz"
  neo4j_viz_sa  = "serviceAccount:${google_service_account.neo4j_viz_sa.email}"
}