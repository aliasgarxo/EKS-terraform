# Amazon EKS Cluster with Terraform

!EKS Cluster

This project uses Terraform to automate the provisioning of a production-ready Amazon Elastic Kubernetes Service (EKS) cluster. 

## Features

- **EKS Cluster**: Creates an EKS cluster with the desired configuration, including node instance type, VPC configuration, and Kubernetes version.
- **Worker Nodes**: Provisions worker nodes using Amazon EC2 Auto Scaling groups. You can configure the instance type, number of nodes, and scaling policies.
- **Security Roles**: Creates IAM roles for the EKS cluster and worker nodes with the necessary permissions to access AWS services like EBS and Amazon ECR.
- **Kubernetes Addons**: Installs optional Kubernetes addons, such as CloudWatch Container Insights, VPC CNI plugin, and ALB Ingress Controller.

## Benefits

- **Infrastructure as Code**: Manage your EKS cluster infrastructure using Terraform configuration files.
- **Self-Service Deployment**: Automate the provisioning and configuration of your EKS cluster, enabling rapid application deployment.
- **Repeatable and Consistent**: Ensure consistent infrastructure across deployments with Terraform's declarative approach.
- **Scalable**: Easily scale your worker nodes using Auto Scaling groups.

## Requirements

- An AWS account with appropriate permissions to create EKS clusters, EC2 instances, IAM roles, and other AWS resources.
- Terraform installed and configured on your local machine.
- Basic familiarity with Terraform and AWS concepts.

## Getting Started

Clone the repository:

```bash
git clone https://github.com/your-username/eks-cluster-terraform.git

