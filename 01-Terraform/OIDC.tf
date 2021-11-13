
# Get TLS Certificate For Creation Of OIDC Identity Provider
data "tls_certificate" "cluster" {
  url = "${aws_eks_cluster.eks.identity.0.oidc.0.issuer}"
}

# Creating OIDC Identity Provider For Authentication & Establishing Communication Between AWS-Api & EKS Cluster   
resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list = ["sts.amazonaws.com"]                                              # Default Audience.
  thumbprint_list = [data.tls_certificate.cluster.certificates.0.sha1_fingerprint]    # TLS Certificate ID.
  url = "${aws_eks_cluster.eks.identity.0.oidc.0.issuer}"                             # OIDC Url.
  depends_on = [aws_eks_cluster.eks]
}

# Resources:
  # aws_iam_openid_connect_provider - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_identity_provider_config#issuer_url

# Articale:
  # Create OIDC With Terraform  - https://marcincuber.medium.com/amazon-eks-with-oidc-provider-iam-roles-for-kubernetes-services-accounts-59015d15cb0c
