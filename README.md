# Amazon EKS Cluster with Terraform

This project uses Terraform to automate the provisioning of a production-ready Amazon Elastic Kubernetes Service (EKS) cluster. 

<img src="https://github.com/aliasgarxo/EKS-terraform/assets/134081765/1abf2c60-f8ed-4e8d-9dda-516714dba040" width="450">

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
```

**Configure Terraform**:
- Edit the variables.tf file to set the desired configuration for your EKS cluster, including the region, node instance type, and number of nodes.
- Configure your AWS credentials using environment variables, a shared credentials file, or a configuration file.

**Provision the EKS cluster**:

Use the following commands to initialize Terraform, plan your infrastructure changes, and apply them:

```bash
terraform init
terraform plan
terraform apply
```

**Verify the deployment**:

- After applying your changes, you can verify the deployment by accessing the EKS cluster console or using `kubectl` to interact with your cluster.

**Manage your EKS cluster**:

- Now that your EKS cluster is up and running, you can start deploying applications, scaling your worker nodes, and exploring other features of Amazon EKS.

## Additional Notes

- This project provides a basic example of provisioning an EKS cluster with Terraform. You can customize the configuration to meet your specific requirements.
- Always test your changes in a controlled environment before deploying them to production.
- Refer to the Terraform documentation for more information on how to use Terraform.
- Refer to the Amazon EKS documentation for more information about EKS.

