# EKS-ALB-Ingress-Controller

## Quick Start


## Summary
Example of deploying CI/CD pipeline via jenkis on master node.<br />
In general, the pipeline basically consists of five stages:
01. Create AWS infrastructures via Terraform.<br /> (Networking, EKS-Cluster, Node-Group , IAM & Policies, OIDC)
02. Create ECR Build & Push images to registry via aws cli. (ECR, Docker) 
03. kubernetes configure and deploy AutoScale & ALB Ingress for serving tensorflow application.
04. Deploy static website via S3 bucket.

* Note: You should probably want to stick to one IAC for each of your infrastructure deployments but there is pros and cons for each tool.
  * terraform - the easies tool for maintenance AWS resources.
  * eksctl - AWS tool for maintenance kubernetes with Cloudformation, easies tool for mange EKS.
  * aws-cli - probably the simplest and easies IAC tool for deploying individuals resources. 

* Check Out code remarks for more specificies info.

<p align="center">
  <img src="https://github.com/matanelg/EKS-ALB-Ingress-Controller/blob/main/images/eks_diagram.png" width="100%" height="100%" />
</p>


## Prerequests
* Terraform 	v1.0.7
* aws-cli 	2.2.21 
* docker 	20.10.7
* kubectl 	v1.22.3
* java 	11.0.11 (for jenkis install via war file)


## Application
The backend (pods) serve post request from frontend (S3) and return prediction for given image. (checkout demo)
* Note: Images must be on PNG format.


## Demo



