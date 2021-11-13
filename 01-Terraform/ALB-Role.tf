# Create Web Identity Role for Kubernetes ALB Ingress.
resource "aws_iam_role" "ALB_Role" {
  name = "AmazonALBIngressControllerRole"
  assume_role_policy = "${data.template_file.AmazonALBIngressControllerRole.rendered}"
  depends_on = [aws_iam_openid_connect_provider.cluster]
}

# Creating template file for updating OIDC ARN, OIDC URL and ServiceAccount on The Web Identity Role.
data "template_file" "AmazonALBIngressControllerRole" {
  template = file("${path.module}/IAM-Files/Role-Policies/AmazonALBIngressControllerRole.json")
  vars = {
      OIDC_ARN = aws_iam_openid_connect_provider.cluster.arn
      OIDC_URL = replace(aws_iam_openid_connect_provider.cluster.url, "https://", "")
      NAMESPACE = "${var.K8s_Variables["NAMESPACE"]}"
      ServiceAccount_Cluster_ALB = "${var.K8s_Variables["ServiceAccount_Cluster_ALB"]}"
    }
  depends_on = [aws_iam_openid_connect_provider.cluster]
}

# Creating ALB Policy for ALBRole Role.
resource "aws_iam_policy" "ALB_Policy" {
  name        = "AmazonALBIngressControllerPolicy"
  path        = "/"
  policy = file("${path.module}/IAM-Files/Policies/AmazonALBIngressControllerPolicy.json")
}

# Attaching ALB Policy to ALBRole Role.
resource "aws_iam_role_policy_attachment" "ALB_Attach_Policy" {
  role       = aws_iam_role.ALB_Role.name
  policy_arn = aws_iam_policy.ALB_Policy.arn
  depends_on = [aws_iam_role.ALB_Role]
}

# Resouces:
  # aws_iam_role - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # aws_iam_role_policy_attachment - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

# Policies:
  # 01. AutoScalerPolicy - Check Out ./IAM-Files/Policies/AmazonALBIngressControllerPolicy.json
