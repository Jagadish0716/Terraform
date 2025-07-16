# Terraform AWS Infrastructure Automation

## Author
Jagadish V

## Purpose
This repository demonstrates best practices for automating AWS infrastructure using Terraform. It covers variables, providers, resources, data sources, outputs, security groups, EC2 instances, EBS volumes, VPCs, and advanced features like lists, maps, and meta-arguments (`count`, `for_each`). Example code and explanations are provided for each topic.

---

## Table of Contents

- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Terraform Topics](#terraform-topics)
  - [Providers](#providers)
  - [Variables](#variables)
  - [Resources](#resources)
  - [Data Sources](#data-sources)
  - [Outputs](#outputs)
  - [Security Groups](#security-groups)
  - [EC2 Instances](#ec2-instances)
  - [EBS Volumes](#ebs-volumes)
  - [VPC](#vpc)
  - [Lists and Maps](#lists-and-maps)
  - [Meta-Arguments: count & for_each](#meta-arguments-count--for_each)
  - [Comments](#comments)
- [Best Practices](#best-practices)
- [How to Use](#how-to-use)
- [Useful Commands](#useful-commands)
- [References](#references)

---

## Getting Started

1. **Install Terraform:**  
   [Download Terraform](https://www.terraform.io/downloads.html) and add it to your PATH.

2. **Configure AWS Credentials:**  
   Set up your AWS credentials using the AWS CLI or environment variables.

3. **Clone the Repository:**  
   ```sh
   git clone https://github.com/Jagadish0716/Terraform.git
   cd your-repo
   ```

---

## Project Structure

```
.
├── EC-2/
│   ├── variables.tf
│   ├── outputs.tf
│   ├── version.tf
│   └── ...
├── LIST-MAP/
│   ├── EC2-INSTANCE.tf
│   ├── outputs.tf
│   ├── version.tf
│   └── ...
├── VPC/
│   ├── version.tf
│   └── ...
├── permissions.txt
└── README.md
```

---

## Terraform Topics

### Providers

Defines the cloud or service to use.  
**Example:**
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
```

---

### Variables

Parameterize your configuration for flexibility.  
**Example:**
```hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
```

---

### Resources

Create AWS resources like EC2, EBS, VPC, etc.  
**Example:**
```hcl
resource "aws_instance" "tf_ubuntu_ec2" {
  ami           = data.aws_ami.ubuntu_linux.id
  instance_type = var.instance_type
  key_name      = var.keypair_name
  ...
}
```

---

### Data Sources

Fetch dynamic information from AWS (e.g., latest AMI).  
**Example:**
```hcl
data "aws_ami" "ubuntu_linux" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

---

### Outputs

Expose resource attributes after deployment.  
**Example:**
```hcl
output "instance_public_ip" {
  value = aws_instance.tf_ubuntu_ec2.public_ip
}
```

---

### Security Groups

Control inbound/outbound traffic for EC2 instances.  
**Example:**
```hcl
resource "aws_security_group" "terraform_sg" {
  name        = var.sg_name
  description = var.sg_description
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ...
}
```

---

### EC2 Instances

Provision virtual machines in AWS.  
**Example:**
```hcl
resource "aws_instance" "tf_ubuntu_ec2" {
  count         = 3
  ami           = data.aws_ami.ubuntu_linux.id
  instance_type = var.instance_type
  ...
}
```

---

### EBS Volumes

Attach storage to EC2 instances.  
**Example:**
```hcl
root_block_device {
  volume_size = var.ebs_volume_size
  volume_type = var.ebs_volume_type
}
```

---

### VPC

Create isolated networks in AWS.  
**Example:**
```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  ...
}
```

---

### Lists and Maps

Use complex data types for scalable configurations.  
**Example:**
```hcl
variable "ec2_instance_type_list" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t2.medium"]
}
```

---

### Meta-Arguments: count & for_each

Create multiple resources dynamically.  
**Example:**
```hcl
resource "aws_instance" "tf_ubuntu_ec2" {
  count = 3
  ...
}
```

---

### Comments

Terraform supports single-line comments only:
```hcl
# This is a comment
// This is also a comment
```

---

## Best Practices

- Use variables for all configurable values.
- Use data sources for dynamic information.
- Output key resource attributes.
- Use lists/maps for scalable infrastructure.
- Use meta-arguments (`count`, `for_each`) for multiple resources.
- Keep resource, variable, and output definitions organized in separate files.
- Add author and purpose comments at the top of each file.

---

## How to Use

1. **Initialize Terraform:**
   ```sh
   terraform init
   ```
2. **Plan the deployment:**
   ```sh
   terraform plan
   ```
3. **Apply the configuration:**
   ```sh
   terraform apply
   ```
4. **Destroy resources (if needed):**
   ```sh
   terraform destroy
   ```

---

## Useful Commands

- `terraform fmt` – Format code
- `terraform validate` – Validate configuration
- `terraform state list` – List resources in state
- `terraform output` – Show outputs
- `terraform taint` – Mark resource for recreation

---

## References

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [GitHub CLI](https://cli.github.com/)

---

**Feel free to explore each folder for topic-specific examples
