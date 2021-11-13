# Terraform
- Terraform is an IAC (Infrastructure As Code) tool which allowed us create resurces on AWS.


## Resources List
* Network:
  * VPC.
  * Two Public Subnets on two different availability zones.
    * We Must Lable Subnets For Kubernetes Will Know where to Deploy ALB.
    ```terraform
      tags = {
        "kubernetes.io/cluster/eks" = "shared"
        "kubernetes.io/role/elb"    = 1
      }
    ```
  * Two Private Subnets on the same two different availability zones.
    * We Must Lable Subnets For Kubernetes Will Know Which Target Group He Need To Auto Scale.
      ```terraform
      tags = {
        "kubernetes.io/cluster/eks" = "shared"
        "k8s.io/cluster-autoscaler/enabled" = true
        "k8s.io/cluster-autoscaler/eks" = "owned"
      }
      ```
  * Internet Gateway
  * Nat Gateway
    * Not really necessary in a production environment, because Kubernetes will already be given permission to access ECR, and also communicate via ALB or any other ingress controller. The real benefit of the NAT is for debugging the pods and give another functionality on top of pod's base image. 
  * EIP
  * Route Table
  * Route Table Association 

* OIDC (OpenID Connect) Provider - Authentication & Establishing Communication Between AWS-Api & EKS Cluster.

* EKS Culster
  * Must be in at least two different availability zones.
  * Subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME

* EKS Node Group
  * Scaling Node Group (desired_size, max_size, min_size)
  * Define Instanes (ami_type, capacity_type, disk_size, instance_types)
  * We Must Lable Node Group For Kubernetes Will Know Which Node Group He Need To Auto Scale.
    ```terraform
    labels = {
    role = "node-label"
    }
    ```

* IAM Role
  * EKS Cluster Role (Service) - Let EKS Cluster basic premmision to observe AWS Resourcs (Networking Resources, EC2 etc.) 
  * EKS Node Group Role (Service) - Let EKS Node Group basic premmision to observe AWS Resourcs (ECR, Subnets, EC2 etc.)
  * Auto Scaler Role (Web Identity) - Let Premmision to Kubernetes create Instances Resource.
  * ALB Role (Web Identity) - Let Premmision to Kubernetes create ALB & Target Group Resources. 

* Policies:
  * AmazonEKSWorkerNodePolicy -  https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  * AmazonEKSWorkerNodePolicy - https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  * AmazonEKS_CNI_Policy - https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
  * AmazonEC2ContainerRegistryReadOnly - https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
  * AmazonALBIngressControllerPolicy - https://github.com/matanelg/EKS-ALB-Ingress-Controller/blob/main/01-Terraform/IAM-Files/Policies/AmazonALBIngressControllerPolicy.json
  * AmzonEKSClusterAutoScalerPolicy - https://github.com/matanelg/EKS-ALB-Ingress-Controller/blob/main/01-Terraform/IAM-Files/Policies/AmzonEKSClusterAutoScalerPolicy.json





