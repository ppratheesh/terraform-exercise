resource "aws_vpc" "vpc_dev" {
    cidr_block = var.AWS_VPC_CIDR
    instance_tenancy= "default"
    enable_dns_support = true
    enable_dns_hostnames = true 
    tags = {
        Name = "vpc_dev"
    }
}
resource "aws_internet_gateway" "igw" {
     vpc_id = aws_vpc.vpc_dev.id
     tags = { Name = "igw-dev" }
}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc_dev.id
    cidr_block = var.AWS_PUBLIC_SUBNET
    availability_zone = var.AWS_PUBLIC_AZ
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet_dev"
    }
}
resource "aws_subnet" "private_subnet" {
    cidr_block = var.AWS_PRIVATE_SUBNET
    vpc_id = aws_vpc.vpc_dev.id
    availability_zone = var.AWS_PRIVATE_AZ
    tags = {
        Name = "private_subnet_dev"
    }
}   
resource  "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.vpc_dev.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "pub_rtb_asc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rtb.id
}

#creating nat gateway for private subnets
resource "aws_eip" "eip_dev"{
    vpc = true
}
resource "aws_nat_gateway" "nat_dev" {
    allocation_id = aws_eip.eip_dev.id
    subnet_id = aws_subnet.public_subnet.id
    depends_on = [aws_internet_gateway.igw]
    tags = {
        Name = "nat_dev"
    }
}
resource "aws_route_table" "rtb_nat" {
    vpc_id = aws_vpc.vpc_dev.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_dev.id
    }
}
resource "aws_route_table_association" "rtb_nat_asc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.rtb_nat.id
}

