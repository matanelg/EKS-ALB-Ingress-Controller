
# Creating EKS Node Group
resource "aws_eks_node_group" "nodes_general" {
  cluster_name    = aws_eks_cluster.eks.name        # Name of the EKS Cluster.
  node_group_name = var.Node_Group_Name             # Name of the EKS Node Group.

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.nodes_general.arn

  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  subnet_ids = [
    aws_subnet.private-01-1a.id,
    aws_subnet.private-02-1b.id
  ]

  # Configuration block with scaling settings
  scaling_config {
    desired_size = 1          # Desired number of worker nodes.
    max_size     = 4          # Maximum number of worker nodes.
    min_size     = 1          # Minimum number of worker nodes.
  }

  ami_type             = "AL2_x86_64"   # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64.
  capacity_type        = "SPOT"         # Valid values: ON_DEMAND, SPOT.
  disk_size            = 12             # Disk size in GiB for worker nodes.
  force_update_version = false          # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  instance_types       = ["t3.medium"]   # List of instance types associated with the EKS Node Group.

  # ********** Very Important ********** #            # We Must Lable Node Group For Kubernetes Will Know Which Node Group He Need To Auto Scale.
  labels = {
    role = "${var.K8s_Variables["Node_Label"]}"
  }
  # ************************************ #

  version = var.Kubernetes_Version["Node_Group"]      # Kubernetes version

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}

# Resources: 
  # aws_eks_node_group - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
