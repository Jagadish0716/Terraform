# Author: Jagadish V
# Purpose: Output key attributes of the deployed EC2 instance, such as public IP, private IP, name, and public DNS

output "instance_public_ip" {
    description = "public IP address of the EC2 instance"
    value       = aws_instance.tf_ubuntu_ec2.public_ip
}

output "instance_private_ip" {
    description = "private IP address of the EC2 instance"
    value       = aws_instance.tf_ubuntu_ec2.private_ip
}

output "instance_name" {
    description = "Name of the EC2 instance"
    value       = aws_instance.tf_ubuntu_ec2.tags["Name"]
}

output "instance_public_dns" {
    description = "Public DNS of the EC2 instance"
    value       = aws_instance.tf_ubuntu_ec2.public_dns
  
}