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
    bucket  = local.project+"-neo4j-viz"
    prefix  = "terraform/state"
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