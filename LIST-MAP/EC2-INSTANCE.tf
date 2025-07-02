# Author: Jagadish V
# Purpose: Define AWS resources such as EC2 instances using dynamic lists and maps for flexibility and scalability
# also using count (meta data argument) to create multiple instances
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "terraform_sg" {
  name        = var.sg_name            
   description = var.sg_description
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.sg_ingress_from_port
    content {
      from_port   = ingress.value                  
      to_port     = ingress.value                 
      protocol    = var.sg_ingress_protocol      
      cidr_blocks = var.sg_ingress_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tag for the security group
  tags = {
    Name = var.sg_name
  }
}

resource "aws_instance" "tf_ubuntu_ec2" {
  ami                    = data.aws_ami.ubuntu_linux.id
  instance_type          = var.ec2_instance_type_list[0]  # Using the first instance type from the list
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.terraform_sg.id]
  count                  = 3 # Creating 3 instances for demonstration

# create each instnace in a different availability zone
 availability_zone      = data.aws_availability_zones.available.names[count.index]

# create each instnace in a specific availability zone
  # availability_zone = var.ec2_az

  root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }
  tags = {
    Name = "${var.tf-ec2-name}-${count.index + 1}" # Unique name for each instance
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}


