resource "aws_instance" "jump-ec2" {
  ami = data.aws_ami.amazon_linux_2023.id
  subnet_id = aws_subnet.arch-pub-sub-1.id
  key_name = aws_key_pair.terra-keypair.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.arch-sg.id]
  instance_type = var.instance-type
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  user_data = file("${path.module}/bastion.sh")
  depends_on = [ local_file.private_key_pem, aws_iam_role.bastion_role, aws_eks_cluster.my_eks_cluster ]

  provisioner "file" {
    source      = "terra-keypair.pem" 
    destination = "/tmp/ssh-key-2024-02-19.key" 
    connection {
      type        = "ssh"
      user        = "ec2-user" 
      private_key = tls_private_key.pri-terra-key.private_key_pem 
      host        = self.public_ip 
    }
  }

  tags = {
    Name = "Bastion-Host"
  }

}