resource "null_resource" "cloudbuild" {

 provisioner "local-exec" {

    command = "cd $HOME/neo4j-gcp-viz && gcloud builds submit -q"
  }

   depends_on = [google_project_service.cloudbuild]
}

resource "null_resource" "docker_pull" {

 provisioner "local-exec" {

    command = "docker pull gcr.io/${data.google_project.project.project_id}/neo4j-gcp-viz"
  }

   depends_on = [null_resource.cloudbuild]
}
