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
terraform state show 'google_storage_bucket.tf-bucket' 2> temp
return_value=`grep -o "No instance found for the given address!" temp | wc -l`

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

gcloud container clusters get-credentials my-gke-cluster --region $2 --project $1
kubectl apply -f deployment.yaml

IP=`gcloud compute forwarding-rules list | grep IP_ADDRESS | cut -d \: -f 2 | sed 's/^ *//g'`
echo $IP

sed -i 's/<PUBLIC_IP>/'$IP'/g' ./node/app.js

sleep 120

gcloud builds submit --config cloudbuild.yaml .

docker pull gcr.io/$1/neo4j-gcp-viz
