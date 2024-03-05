variable "region" {
  default = "us-east-2"
}

variable "instance-type" {
  default = "t2.micro"
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.20240205.2-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ami" "amazon_linux_eks" { 
  most_recent = true

  owners = ["amazon"] 

  filter {
    name   = "name"
    values = ["amazon-eks-node-*"] # Update pattern for EKS AMIs
  }
}

variable "vpc-name" {
  default = "dellhoak"
}
variable "cidr-block" {
  default = "69.69.0.0/16"
}
variable "cluster_name" {
  default = "dell-eks"
}
variable "kubernetes_version" {
  default = "1.29"
}
variable "nodegroup_name" {
  default = "dell-ng-eks"
}
variable "nodegroup_desired_size" {
  default = "2"
}
variable "nodegroup_max_size" {
  default = "4"
}
variable "nodegroup_min_size" {
  default = "2"
}
