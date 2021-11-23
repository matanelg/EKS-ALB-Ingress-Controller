# EKS-ALB-Ingress-Controller

## Prerequests
* Terraform       v1.0.7         [Terraform installation link](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* aws-cli         2.2.21         [aws-cli installation link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* docker          20.10.7        [docker installation link](https://docs.docker.com/engine/install/ubuntu/)
* kubectl         v1.22.3        [kubectl installation link](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
* java            11.0.11        [java installation link](https://www.tecmint.com/install-java-with-apt-on-ubuntu/)
* jenkis          2.303.3 LTS    [jenkis installation link](https://www.jenkins.io/download/)


## Quick Start
01. Configure your aws credentials at ~/.aws/credentials
```bash
[default]
aws_access_key_id = ""
aws_secret_access_key = ""
```
* Note: **profile name must be default (there are bash scripts that depend on it)**

02. start jenkis & go to localhost:8080
```bash
java -jar jenkins.war
```
03. Create new pipeline.  Dashboard >> New Item
04. Copy Jenkisdile from the repository to the pipeline tab and save it
05. Build


## Summary
Example of deploying CI/CD pipeline via jenkis on master node.<br />
In general, the pipeline basically consists of four stages:
01. Create AWS infrastructures via Terraform.<br /> (Networking, EKS-Cluster, Node-Group , IAM & Policies, OIDC)
02. Create ECR Build & Push images to registry via aws cli. (ECR, Docker) 
03. kubernetes configure and deploy AutoScale & ALB Ingress for serving tensorflow application.
04. Deploy static website via S3 bucket.

* Note: You should probably want to stick to one IAC for each of your infrastructure deployments but there is pros and cons for each tool.
  * terraform - the easies tool for maintenance AWS resources.
  * eksctl - maintenance kubernetes with Cloudformation, easies tool for mange EKS.
  * aws-cli - probably the simplest and easies IAC tool for deploying individuals resources. 

* Check Out code remarks for more specificies info.

<p align="center">
  <img src="https://github.com/matanelg/EKS-ALB-Ingress-Controller/blob/main/images/eks_diagram.png" width="100%" height="100%" />
</p>


## Application
The backend pods serve post request from frontend S3 static web page and return prediction for given image. (checkout demo)
* Note: Images must be on PNG format.


## Demo

### Application

https://user-images.githubusercontent.com/64362937/141658655-041e356c-2f8e-4444-a351-ff2bc182098b.mp4

### Auto Scale

https://user-images.githubusercontent.com/64362937/141658669-f0d486af-9dd0-47c3-b988-472375e98896.mp4


