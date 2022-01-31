#!/bin/bash


sed -i 's/<PLACEHOLDER_BUCKET>/'$1'-neo4j-viz/g' ./terraform/main.tf
sed -i 's/<PLACEHOLDER_PROJECTID>/'$1'/g' ./terraform/main.tf

cd terraform 
terraform init
terraform destroy
cd ..