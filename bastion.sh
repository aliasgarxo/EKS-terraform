#!/bin/bash
sudo yum update -y && sudo yum upgrade -y
export REGION="${var.region}"
export CLUSTER_NAME="${aws_eks_cluster.your_eks_cluster.name}"

curl -LO "https://dl.k8s.io/release/v1.29.2/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/v1.29.2/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

aws eks update-kubeconfig --region us-east-2 --name dell-eks
