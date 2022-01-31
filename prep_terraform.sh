#!/bin/bash
ls
pwd
#cat node/db.txt

# Pull the image (I did it on Cloud Shell)
docker pull neo4j

# Tag the image
docker tag neo4j gcr.io/$1/neo4j


cd terraform
terraform init
terraform state show 'google_storage_bucket.tf-bucket'

return_value=$?
grep -o 'No instance found for the given address!.*' <<< "$return_value" | wc -l
return_value=$?
if [[ $return_value == 0 ]] 
then
    echo "Bucket managed"
else
    echo "Bucket not managed"
    terraform import google_storage_bucket.tf-bucket $1-neo4j-viz
    #gsutil mb gs://${1}-neo4j-viz
fi


terraform state pull
terraform apply -auto-approve -var region=$2

cd ..

gcloud container clusters get-credentials my-gke-cluster --region us-central1 --project neo4j-339806
kubectl apply -f deployment.yaml

#gcloud builds submit --config cloudbuild.yaml .

#docker pull gcr.io/$1/neo4j-gcp-viz
