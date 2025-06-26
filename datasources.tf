data "aws_ami" "ubuntu_linux" {
    most_recent = true
    owners      = ["099720109477"] # Canonical

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        # Filter for root-device-type to ensure the AMI uses EBS volumes for storage
        name   = "root-device-type"
        values = ["ebs"]
    }
}
