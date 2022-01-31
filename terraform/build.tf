resource "null_resource" "cloudbuild" {

 provisioner "local-exec" {

    command = "cd $HOME/neo4j-gcp-viz && gcloud builds submit --config cloudbuild.yaml $HOME/neo4j-gcp-viz/node"
  }

   depends_on = [google_project_service.cloudbuild]
}
