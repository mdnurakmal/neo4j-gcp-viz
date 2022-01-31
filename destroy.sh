#!/bin/bash

cd terraform

sed -i 's/<PLACEHOLDER_BUCKET>/'$1'-neo4j-viz/g' ./terraform/main.tf
sed -i 's/<PLACEHOLDER_PROJECTID>/'$1'/g' ./terraform/main.tf

terraform init
terraform destroy