# Author: Jagadish V
# Purpose: Output key attributes of the deployed EC2 instance, such as public IP, private IP, name, and public DNS

//########## for loop with list ##########
//# ec-instance name
//output "for_loop_list-ec2_instance_name" {
//  description = "Name of the EC2 instance created using for loop with list"
//  value       = [for instance in aws_instance.tf_ubuntu_ec2 : instance.tags["Name"]] 
//}
//
//#ec2 public IP
//output "for_loop_list-ec2_instance_public_ip" {
//  description = "Public IP of the EC2 instance created using for loop with list"
//  value       = [for instance in aws_instance.tf_ubuntu_ec2 : instance.public_ip]
//}
//
//#ec2 private IP
//output "for_loop_list-ec2_instance_private_ip" {
//  description = "Private IP of the EC2 instance created using for loop with list"
//  value       = [for instance in aws_instance.tf_ubuntu_ec2 : instance.private_ip]
//}
//
//#ec2 public DNS
//output "for_loop_list-ec2_instance_public_dns" {
//  description = "Public DNS of the EC2 instance created using for loop with list"
//  value       = [for instance in aws_instance.tf_ubuntu_ec2 : instance.public_dns]
//}
//
//#ec2 private DNS
//output "for_loop_list-ec2_instance_private_dns" {
//  description = "Private DNS of the EC2 instance created using for loop with list"
//  value       = [for instance in aws_instance.tf_ubuntu_ec2 : instance.private_dns]
//}

# Output a map of instance names to their public and private IPs
output "for_loop_list-ec2_instance_details" {
    description = "Map of EC2 instance names to their public and private IPs"
    value = {
        for instance in aws_instance.tf_ubuntu_ec2 :
            instance.tags["Name"] => {
                public_ip  = instance.public_ip
                private_ip = instance.private_ip
                public_dns = instance.public_dns
                private_dns = instance.private_dns
            }
    }
}


########## latest splat operator ##########
/*output "splat-ec2_instance_name" {
  description = "Name of the EC2 instance created using splat operator"
  value       = aws_instance.tf_ubuntu_ec2[*].tags["Name"]
}

output "splat-ec2_instance_public_ip" {
  description = "Public IP of the EC2 instance created using splat operator"
  value       = aws_instance.tf_ubuntu_ec2[*].public_ip 
}

output "splat-ec2_instance_private_ip" {
  description = "Public IP of the EC2 instance created using splat operator"
  value       = aws_instance.tf_ubuntu_ec2[*].private_ip 
}

output "splat-ec2_instance_public_dns" {
  description = "Public DNS of the EC2 instance created using splat operator"
  value       = aws_instance.tf_ubuntu_ec2[*].public_dns 
}

output "splat-ec2_instance_private_dns" {
  description = "Private DNS of the EC2 instance created using splat operator"
  value       = aws_instance.tf_ubuntu_ec2[*].private_dns 
} 
*/ 

# It provides all key details (name, public/private IP, DNS) for each instance in a single, structured output
output "splat-ec2_instance_details" {
  description = "Map of EC2 instance names to their public and private IPs and AZ using splat operator"
  value = {
    for idx, name in aws_instance.tf_ubuntu_ec2[*].tags["Name"] :
      name => {
        public_ip   = aws_instance.tf_ubuntu_ec2[idx].public_ip
        private_ip  = aws_instance.tf_ubuntu_ec2[idx].private_ip
        public_dns  = aws_instance.tf_ubuntu_ec2[idx].public_dns
        private_dns = aws_instance.tf_ubuntu_ec2[idx].private_dns
        availability_zone = aws_instance.tf_ubuntu_ec2[idx].availability_zone
      }
  }
}
