
# Creating EKS Cluster
resource "aws_eks_cluster" "eks" {
  name     = var.Cluster_Name                       # Name of the cluster.
  role_arn = aws_iam_role.eks_cluster.arn           # The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf.
  version  = var.Kubernetes_Version["Cluster"]      # Desired Kubernetes master version.
  vpc_config {
    endpoint_private_access = false                 # Indicates whether or not the Amazon EKS private API server endpoint is enabled.
    endpoint_public_access  = true                  # Indicates whether or not the Amazon EKS public API server endpoint is enabled.
    # Must be in at least two different availability zones.
    subnet_ids = [
      aws_subnet.private-01-1a.id,
      aws_subnet.private-02-1b.id,
      aws_subnet.public-01-1a.id,
      aws_subnet.public-02-1b.id
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}

# Resources: 
  # aws_eks_cluster - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
