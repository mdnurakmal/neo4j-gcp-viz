resource "google_compute_firewall" "neo4j-ingress" {
  name    = "neo4j-ingress"
  network = google_compute_network.default.name

  allow {
    protocol = "neo4j"
  }

  allow {
    protocol = "tcp"
    ports    = ["7474", "7687", "7473"]
  }

  direction = "INGRESS"

 depends_on = [google_compute_network.default]
}

resource "google_compute_firewall" "neo4j-egress" {
  name    = "neo4j-egress"
  network = google_compute_network.default.name

  allow {
    protocol = "neo4j"
  }

  allow {
    protocol = "tcp"
    ports    = ["7474", "7687", "7473"]
  }

  direction = "EGRESS"

    depends_on = [google_compute_network.default]
}

resource "google_compute_network" "default" {
  name = "default"

  lifecycle {
    create_before_destroy = true
  }
}