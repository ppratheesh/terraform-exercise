resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_vpc
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
   tags = {
   Environment = var.environment_tag
   }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
  Environment = var.environment_tag
  }
}
resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.test_vpc.id
cidr_block = var.cidr_public_subnet
map_public_ip_on_launch = true
availability_zone = var.availability_zone_pubic
tags = {
Environment = var.environment_tag
}
}
resource "aws_subnet" "private_subnet" {
 vpc_id = aws_vpc.test_vpc.id
 cidr_block = var.cidr_private_subnet
 availability_zone = var.availability_zone_private
 tags = {
 Environment = var.environment_tag
  }
 }
 resource "aws_route_table" "rtb_public" {
    vpc_id=aws_vpc.test_vpc.id
    route {
       cidr_block = "0.0.0.0/0"
       gateway_id = aws_internet_gateway.igw.id
    }
 }
 resource "aws_route_table_association" "rtb_for_public" {
    subnet_id = aws_subnet.public
    route_table_id = aws_route_table.rtb_public.id
 }
 resource "aws_security_group" "web" {
 name = "web-SG"
 vpc_id= aws_vpc.test_vpc.id
 ingress {
  from_port = 22
  to_port   = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   from_port = 80
   to_port   = 80
   protocol  = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
   from_port = 443
   to_port   = 443
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
   from_port = 0
   to_port   = 0
   protocol  = "-1"
   cidr_blocks = ["0.0.0.0/0"]

 }
