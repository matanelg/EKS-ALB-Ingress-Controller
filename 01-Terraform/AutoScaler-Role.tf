
# Creating Web Identity Role for Kubernetes Auto Scaler.
resource "aws_iam_role" "AutoScalerRole" {
  name = "AmzonEKSClusterAutoScalerRole"
  assume_role_policy = "${data.template_file.AmzonEKSClusterAutoScalerRole.rendered}"
  depends_on = [aws_iam_openid_connect_provider.cluster]
}

# Creating template file for updating OIDC ARN, OIDC URL and ServiceAccount on The Web Identity Role
data "template_file" "AmzonEKSClusterAutoScalerRole" {
  template = file("${path.module}/IAM-Files/Role-Policies/AmzonEKSClusterAutoScalerRole.json")
  vars = {
      OIDC_ARN = aws_iam_openid_connect_provider.cluster.arn
      OIDC_URL = replace(aws_iam_openid_connect_provider.cluster.url, "https://", "")
      NAMESPACE = "${var.K8s_Variables["NAMESPACE"]}"
      ServiceAccount_Cluster_Autoscaler = "${var.K8s_Variables["ServiceAccount_Cluster_Autoscaler"]}"
    }
  depends_on = [aws_iam_openid_connect_provider.cluster]
}

# Creating AutoScaler Policy for AutoScaler Role.
resource "aws_iam_policy" "AutoScalerPolicy" {
  name        = "AmzonEKSClusterAutoScalerPolicy"
  path        = "/"
  policy = file("${path.module}/IAM-Files/Policies/AmzonEKSClusterAutoScalerPolicy.json")
}

# Attaching AutoScaler Policy to AutoScaler Role.
resource "aws_iam_role_policy_attachment" "AutoScaler_Attach_Policy" {
  role       = aws_iam_role.AutoScalerRole.name
  policy_arn = aws_iam_policy.AutoScalerPolicy.arn
  depends_on = [aws_iam_role.AutoScalerRole]
}

# Resouces:
  # aws_iam_role - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # aws_iam_role_policy_attachment - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

# Policies:
  # 01. AutoScalerPolicy - Check Out ./IAM-Files/Policies/AmzonEKSClusterAutoScalerPolicy.json
