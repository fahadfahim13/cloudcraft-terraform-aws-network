# VPC Configuration

# This Terraform configuration file sets up a Virtual Private Cloud (VPC) in AWS
# along with associated networking components.

# The following resources will be created:
# 1. VPC
# 2. Internet Gateway
# 3. Route Table
# 4. Two Public Subnets
# 5. Four Private Subnets

# Note: Make sure you have the necessary AWS provider configured in your Terraform setup.

# Create the main VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr  # IP range for the VPC
  instance_tenancy     = "default"     # Use default tenancy for EC2 instances
  enable_dns_support   = true          # Enable DNS support within the VPC
  enable_dns_hostnames = true          # Enable DNS hostnames for EC2 instances

  tags = {
    Name               = "fahim-vpc"   # Tag the VPC for easy identification
  }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id  # Attach to the VPC we just created

  tags = {
    Name = "fahim-igw"     # Tag the Internet Gateway
  }
}

# Create a main route table for the VPC
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id  # Associate with our VPC

  route {
    cidr_block = "0.0.0.0/0"                    # Route all external traffic
    gateway_id = aws_internet_gateway.igw.id    # through the Internet Gateway
  }

  tags = {
    Name = "main-rtb"      # Tag the route table
  }
}

# Create the first public subnet
resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.vpc.id              # Place in our VPC
  cidr_block = var.public_subnet_cidr1     # IP range for this subnet
  map_public_ip_on_launch = true           # Automatically assign public IPs to instances in this subnet
  availability_zone = "ap-southeast-2a"    # Specify the AZ

  tags = {
    Name = "fahim-subnet1"  # Tag the subnet
  }
}

# Create the second public subnet
resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.vpc.id              # Place in our VPC
  cidr_block = var.public_subnet_cidr2     # IP range for this subnet
  map_public_ip_on_launch = true           # Automatically assign public IPs to instances in this subnet
  availability_zone = "ap-southeast-2b"    # Specify the AZ

  tags = {
    Name = "fahim-subnet2"  # Tag the subnet
  }
}

# Associate the first public subnet with the main route table
resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.rtb.id
}

# Associate the second public subnet with the main route table
resource "aws_route_table_association" "rta-subnet2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.rtb.id
}

# Create the first private subnet (App Server)
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc.id              # Place in our VPC
  cidr_block = var.private_subnet_cidr1    # IP range for this subnet
  availability_zone = "ap-southeast-2a"    # Specify the AZ
  map_public_ip_on_launch = false          # Do not assign public IPs

  tags = {
    Name = "fahim-subnet-private-1 | App Server"  # Tag the subnet
  }
}

# Create the second private subnet (DB Server)
resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpc.id              # Place in our VPC
  cidr_block = var.private_subnet_cidr2    # IP range for this subnet
  availability_zone = "ap-southeast-2b"    # Specify the AZ
  map_public_ip_on_launch = false          # Do not assign public IPs

  tags = {
    Name = "fahim-subnet-private-2 | DB Server"  # Tag the subnet
  }
}

# Create the third private subnet (Cache Server)
resource "aws_subnet" "private_subnet3" {
  vpc_id     = aws_vpc.vpc.id              # Place in our VPC
  cidr_block = var.private_subnet_cidr3    # IP range for this subnet
  availability_zone = "ap-southeast-2a"    # Specify the AZ
  map_public_ip_on_launch = false          # Do not assign public IPs

  tags = {
    Name = "fahim-subnet-private-3 | Cache Server"  # Tag the subnet
  }
}

# Create the fourth private subnet (Monitoring Server)
resource "aws_subnet" "private_subnet4" {
  vpc_id     = aws_vpc.vpc.id              # Place in our VPC
  cidr_block = var.private_subnet_cidr4    # IP range for this subnet
  availability_zone = "ap-southeast-2b"    # Specify the AZ
  map_public_ip_on_launch = false          # Do not assign public IPs

  tags = {
    Name = "fahim-subnet-private-4 | Monitoring Server"  # Tag the subnet
  }
}
