# Author: Jagadish V
# Purpose: Define all input variables for EC2, EBS, and Security Group configuration

# AWS region where resources will be deployed
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Name of the key pair for SSH access
variable "keypair_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "terraform-key-us-east-1"
}

########################################## EC2-instance Variables ##########################################
# EC2 instance type to launch
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
  sensitive   = true
}
variable "tf-ec2-name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "terraform-ec2-instance"
}

##########################################EBS volume size for the EC2 instance ##########################################
variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB for the EC2 instance"
  type        = number
  default     = 20
}

variable "ebs_volume_type" {
  description = "Type of the EBS volume for the EC2 instance"
  type        = string
  default     = "gp2" # General Purpose SSD (gp2) or gp3
  
}

########################################## Security Group Variables ##########################################
# You can attach up to 5 security groups to a single EC2 instance in most AWS regions by default.
# Name of the security group to be created
variable "sg_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-security-group"
}

# Description for the security group
variable "sg_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group managed by Terraform"
}

# List of CIDR blocks allowed for ingress rules
variable "sg_ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# List of ports to allow for ingress rules
variable "sg_ingress_from_port" {
  description = "List of ports to allow for ingress"
  type        = list(number)
  default     = [22, 443, 8080]
}

# List of ending ports for ingress rules (same as from_port for single-port rules)
variable "sg_ingress_to_port" {
  description = "Ending port for ingress"
  type        = list(number)
  default     = [22, 443, 8080]
}

# Protocol to use for ingress rules (e.g., tcp)
variable "sg_ingress_protocol" {
  description = "Protocol for ingress"
  type        = string
  default     = "tcp"
}