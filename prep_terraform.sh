#!/bin/bash
ls
pwd
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
gcloud config set project $1 $2
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