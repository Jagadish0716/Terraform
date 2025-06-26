# Data source to fetch the default VPC in the selected AWS region
data "aws_vpc" "default" {
  default = true
}

# Resource block to create a security group in the default VPC
resource "aws_security_group" "terraform_sg" {
  name        = var.sg_name            # Name of the security group, provided by variable
  description = var.sg_description     # Description of the security group, provided by variable
  vpc_id      = data.aws_vpc.default.id # Attach the security group to the default VPC

  # Dynamic block to create multiple ingress rules based on the list of ports provided
  dynamic "ingress" {
    for_each = var.sg_ingress_from_port
    content {
      from_port   = ingress.value                  # Start port for the rule
      to_port     = ingress.value                  # End port for the rule (same as start for single port)
      protocol    = var.sg_ingress_protocol        # Protocol for the rule (e.g., tcp)
      cidr_blocks = var.sg_ingress_cidr_blocks     # List of allowed CIDR blocks
    }
  }

  # Egress rule to allow all outbound traffic
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
  instance_type          = var.instance_type
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.terraform_sg.id]

 root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }
  tags = {
    Name = var.tf-ec2-name
  }
}