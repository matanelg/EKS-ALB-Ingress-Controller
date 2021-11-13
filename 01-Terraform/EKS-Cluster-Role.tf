
# Creatong IAM role for Kubernetes Cluster ( Let EKS basic permission to create resources )
resource "aws_iam_role" "eks_cluster" {
  name               = "eks-cluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attaching policies to role  ( What resources we can apply ) 
resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"       # The ARN of the policy you want to apply
  role       = aws_iam_role.eks_cluster.name                          # The role the policy should be applied to
}

# Resources:
  # aws_iam_role - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # aws_iam_role_policy_attachment - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

# Polices:
  # 01. AmazonEKSClusterPolicy-  https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
