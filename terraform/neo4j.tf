resource "google_cloud_run_service" "default" {
  name     = "neo4j-serv"
  location = "asia-southeast1"

  template {
    spec {
      containers {
        image = "gcr.io/${local.project}/neo4j"
        ports {
            name = "neo4j-7474"
            container_port = 7474
        }
        ports {
            name = "neo4j-7687"
            container_port = 7687
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}