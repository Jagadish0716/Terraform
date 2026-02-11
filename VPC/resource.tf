# 1. Create VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo_vpc"
  }    
}

# 2. Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.1.0/24" # Changed to .1.0 to avoid overlap with private
  map_public_ip_on_launch = true          # Recommended for public subnets
  tags = {
    Name = "public_subnet"
  }
}

# 3. Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private_subnet"
  }
}

# 4. Create Internet Gateway
resource "aws_internet_gateway" "demo_igw" {   
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo_igw"
  }
}

# 5. Public Route Table (with IGW route)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "public_rt"
  } 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
}

# 6. Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 7. Private Route Table (Standard local routing only)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "private_rt"
  }
}

# 8. Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}