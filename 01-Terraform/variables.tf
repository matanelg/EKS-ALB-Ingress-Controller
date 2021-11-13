
# AWS Region
variable "AWSregion" {
  default = "us-east-1"
}

# EKS Cluster Name
variable "Cluster_Name" {
  default = "eks"
}

# EKS Node Group Name
variable "Node_Group_Name" {
  default = "nodes-01"
}

# Kubernetes Variables
variable "K8s_Variables" {
  type = map(string)
  default = {
    "NAMESPACE" = "kube-system"                                 # Namespace For Service Account.
    "ServiceAccount_Cluster_Autoscaler" = "cluster-autoscaler"  # Name Of Auto Scale Controller Service Account.
    "ServiceAccount_Cluster_ALB" = "alb-ingress-controller"     # Name Of Application Load Balancer Ingress Controller Service Account.
    "Node_Label" = "nodes-general"
  }
}

# Kubernetes Version
variable "Kubernetes_Version" {
  type = map(string)
  default = {
    "Cluster" = "1.21"      # EKS-Cluster Version.
    "Node_Group" = "1.20"   # EKS-Node-Group Version (Important for kubernetes Auto Scale).
  }
}
