resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_vpc
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id
}
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = var.cidr_public
  availability_zone = var.avail_pub
  map_public_ip_on_launch = true

}
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = var.cidr_private
  availability_zone = var.avail_private
}
resource "aws_route_table" "rtb_pub" {
  vpc_id = aws_vpc.test_vpc.id
  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rtb_asc" {
   subnet_id = aws_subnet.public_subnet.id
   route_table_id = aws_route_table.rtb_pub.id
}
resource "aws_security_group" "web" {
  name = "web-SG"
  vpc_id = aws_vpc.test_vpc.id
  ingress {
    from_port = 22
    to_port  = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port  = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port  = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
