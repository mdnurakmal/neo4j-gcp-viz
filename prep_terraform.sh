#!/bin/bash

gcloud config set project $1
cd terraform
terraform init
terraform state show 'google_storage_bucket.tf-bucket'

return_value=$?
if [[  "`echo $return_value | grep 'No instance found for the given address!'`" == "No instance found for the given address!" ]] 
then
    echo "Bucket not managed"
else
    echo "Bucket managed"
    #gsutil mb gs://${1}-neo4j-viz
fi

# "cd terraform && terraform import google_storage_bucket.tf-bucket ${GOOGLE_CLOUD_PROJECT}-neo4j-viz",
# "cd terraform && terraform state pull",
# "cd terraform && terraform apply -auto-approve -var region=$GOOGLE_CLOUD_REGION"

# cd..