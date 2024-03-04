resource "aws_iam_role" "eks_cluster_role" {
  name = "EKS-Cluster"

  # Assume role policy for the EKS service
  assume_role_policy = <<EOF
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
EOF

  # Attach the necessary managed policy
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}




# Role for EKS Node Group (EKS-Node)
resource "aws_iam_role" "eks_node_role" {
  name = "EKS-Node"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

data "aws_eks_cluster" "main" {
  name = aws_eks_cluster.my_eks_cluster.name 
}
data "aws_caller_identity" "current" {
}

locals {
  eks_cluster_identity = data.aws_eks_cluster.main.identity[0]
  oidc_issuer_hostname = replace(local.eks_cluster_identity.oidc[0].issuer, "https://", "")
}

# Role for Amazon EBS CSI Driver
resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_issuer_hostname}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${local.oidc_issuer_hostname}:aud": "sts.amazonaws.com",
          "${local.oidc_issuer_hostname}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa" 
        }
      }
    }
  ]
}
EOF

  # Attach AmazonEBSCSIDriverPolicy
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  ]
}