# Serverless GCP visualizer with Neo4j

# Prerequisite
1. GCP account with billing enabled
2. At least 1 existing Project

# Usage

1. Click 'Run on Google' button
2. Follow instructions in cloud shell

[![Run on Google
Cloud](https://deploy.cloud.run/button.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/mdnurakmal/neo4j-gcp-viz.git&cloudshell_image=gcr.io/cloudrun/button&shellonly=true)


# How to remove
1. Open cloud shell / If data in cloud shell is deleted , clone the repository again
2. Run the following command in cloud shell

```shell
. destroy.sh
```

# Objective
- One click to deploy GO app on Google Cloud Platform using terraform
- Serverless architecture


# Notes
What is the workaround for local variable cannot be used for terraform backend 
- Create bucket first then import to terraform

Cloud run has a limit of 32 mb per request

Unable to use default build from app.json because source is in another folder , not in root folder

Unable to pull image directly from dockerhub into cloud run so have to pull from dockerhub first and push to gcp registry first

Cloud run only allows 1 expose port but neo4j requires 2 port 

If a new resource is created from kubernetes , how do we let terraform manage it ?

To do 
Currently it assume there is only 1 Public IP (1 Load balancer)

echo $DEVSHELL_PROJECT_ID