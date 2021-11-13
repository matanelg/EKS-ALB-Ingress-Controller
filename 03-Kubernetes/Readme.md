# Kubernetes
## Summary
01. How kubernetes create AWS resources in our account ? 
02. Two different way to deploy our application
03. Bash Script

## How kubernetes create AWS resources in our account ? 
If you notice before we created two IAM roles with type of web identity,
one for auto scaling and the second for application load balancer ingress
this type of role let premmision for outside services to create aws resource in our account.
all we need its to take role's arn and attach it to kubernetes service account.
the service account is a basic object of kubernetes and by given him also rbac premmision to monitor
objects in our cluster we can deploy any controller we want with cost to cost premmisions
and this is how kubernetes in our case can scale nodes and create load balancer.

## Two different way to deploy our application

* Deploy app by connect him to NodePort service type.
* Deploy nginx reverse proxy and connect him to NodePort service,
then connect him internal to ClusterIP service where our app serve. 

for this repository we check out the first option.


## Bash Script
### 00. Connect to the Cluster
```bash
rm ~/.kube/config
aws eks --region us-east-1 update-kubeconfig --name eks --profile default
```
### 01. Change sensetive values on yaml files
```bash
account_id=$(aws sts get-caller-identity --query Account --output text)
repo_path="$account_id.dkr.ecr.$region.amazonaws.com/$repo_name"
for file in $(ls -1 k8s); 
do
sed -i "s|iii|"$account_id"|g" k8s/$file
sed -i "s|___|"$repo_path"|g" k8s/$file
done
```
### 02. Deploy our objects
```bash
kubectl apply -f k8s
```
