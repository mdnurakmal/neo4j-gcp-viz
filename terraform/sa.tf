# Create a service account
resource "google_service_account" "neo4j_viz_sa" {
  account_id   = "neo4j-viz-sa-id"
  display_name = "Neo4j SA"
}