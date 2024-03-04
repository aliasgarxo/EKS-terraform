resource "aws_eks_cluster" "my_eks_cluster" {
    name     = var.cluster_name
    role_arn = aws_iam_role.eks_cluster_role.arn

    vpc_config {
        subnet_ids = [aws_subnet.arch-pub-sub-1.id, aws_subnet.arch-pub-sub-2.id]
        security_group_ids = [aws_security_group.arch-sg.id] 
    }

    version = var.kubernetes_version
    depends_on = [ aws_vpc.arch-vpc ]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE" 
}
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
}
resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
}
resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "eks-pod-identity-agent"
  resolve_conflicts_on_create = "OVERWRITE"
}
resource "aws_eks_addon" "ebs-csi" {
  cluster_name = aws_eks_cluster.my_eks_cluster.name
  addon_name   = "aws-ebs-csi-driver"
  resolve_conflicts_on_create = "OVERWRITE"
  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn
  depends_on = [ aws_iam_role.ebs_csi_driver_role ]
}


resource "aws_eks_node_group" "my_nodegroup" {
    cluster_name    = aws_eks_cluster.my_eks_cluster.name
    node_group_name = var.nodegroup_name
    instance_types = ["t3.medium"]
    ami_type = "AL2023_x86_64_STANDARD"
    node_role_arn   = aws_iam_role.eks_node_role.arn
    subnet_ids      = [aws_subnet.arch-pub-sub-1.id, aws_subnet.arch-pub-sub-2.id]  # Use private subnets for nodes
    scaling_config {
        desired_size = var.nodegroup_desired_size
        max_size     = var.nodegroup_max_size
        min_size     = var.nodegroup_min_size
    }
    labels = {
        "team" = "production"
    }
    depends_on = [ aws_eks_cluster.my_eks_cluster ]
}