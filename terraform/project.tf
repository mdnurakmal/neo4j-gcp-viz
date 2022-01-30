resource "google_project_service" "run" {
  service = "run.googleapis.com"
  disable_on_destroy = true
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
  disable_on_destroy = true
}

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = true
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_on_destroy = true
}

resource "google_project_service" "logging" {
  service = "logging.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true
}

