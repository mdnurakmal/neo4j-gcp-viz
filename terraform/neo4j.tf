resource "google_cloud_run_service" "default" {
  name     = "neo4j-serv"
  location = "asia-southeast1"

  template {
    spec {
      containers {
        image = "docker.io/neo4j"
        ports = [7474,7687]
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}