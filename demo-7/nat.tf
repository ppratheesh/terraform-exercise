resource "aws_eip" "nat_pub" {
   vpc = true
}
resource "aws_nat_gateway" "nat_pub_gw" {
   allocation_id = aws_eip.nat_pub.id
   subnet_id   = aws_subnet.public_subnet.id
   depends_on = ["aws_internet_gateway.igw"]
}
resource "aws_route_table" "rtb_nat" {
  vpc_id = aws_vpc.test_vpc.id
  route {
     cidr_block = "0.0.0.0/0"
     nat_gateway_id = aws_nat_gateway.nat_pub_gw.id
  }
}
resource "aws_route_table_association" "rtb_nat_asc" {
   subnet_id = aws_subnet.private_subnet.id
   route_table_id = aws_route_table.rtb_nat.id
}
