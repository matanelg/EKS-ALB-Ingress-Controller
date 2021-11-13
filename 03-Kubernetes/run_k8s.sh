#!/bin/bash

# Not need with jenkis
#repo_name="ecr-08"
#region="us-east-1"


# 00. Connect to the Cluster
rm ~/.kube/config
aws eks --region us-east-1 update-kubeconfig --name eks --profile default

# 01. Change sensetive values
account_id=$(aws sts get-caller-identity --query Account --output text)
repo_path="$account_id.dkr.ecr.$region.amazonaws.com/$repo_name"

for file in $(ls -1 k8s); 
do
sed -i "s|iii|"$account_id"|g" k8s/$file
sed -i "s|___|"$repo_path"|g" k8s/$file
done

# 02. Deploy Objects
kubectl apply -f k8s
