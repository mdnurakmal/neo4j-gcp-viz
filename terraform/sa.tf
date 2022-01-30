# Create a service account
resource "google_service_account" "neo4j_viz_sa" {
  account_id   = "neo4j-viz-sa-id"
  display_name = "Neo4j SA"
}

# Set permissions
resource "google_project_iam_binding" "service_permissions" {

  role       = "roles/speech.admin"
  members    = [local.neo4j_viz_sa]
  depends_on = [google_service_account.neo4j_viz_sa]
}