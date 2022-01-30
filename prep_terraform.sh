#!/bin/bash

gcloud config set project $1
cd terraform
terraform init
terraform state show 'google_storage_bucket.tf-bucket'

return_value=$?
grep -o 'No instance found for the given address!.*' <<< "$return_value" | wc -l
return_value=$?
if [[  $return_value != 0]] 
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