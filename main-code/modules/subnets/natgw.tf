resource "aws_nat_gateway" "po-ngw" {
  count = length(var.pub_subnet_cidr)
  subnet_id     = aws_subnet.po-pub-subnet[count.index].id
  allocation_id = aws_eip.po-natgw-eip[count.index].id
  tags = {
    Name = "${var.nat_gateway_name}-${count.index}"
  }
}
resource "aws_eip" "po-natgw-eip" {
  count = length(var.pub_subnet_cidr)
  vpc = true
  tags = {
    Name = "${var.nat_gateway_eip_name}-${count.index}"
  }
}

# ---- Version 1
/*resource "aws_nat_gateway" "po-ngw-1" {
  subnet_id     = aws_subnet.po-pub-subnet-1.id
  allocation_id = aws_eip.po-natgw-eip-1.id
  tags = {
    Name = "PO-Nat-Gateway-1"
  }
}
resource "aws_nat_gateway" "po-ngw-2" {
  subnet_id     = aws_subnet.po-pub-subnet-2.id
  allocation_id = aws_eip.po-natgw-eip-2.id
  tags = {
    Name = "PO-Nat-Gateway-2"
  }
}
resource "aws_nat_gateway" "po-ngw-3" {
  subnet_id     = aws_subnet.po-pub-subnet-3.id
  allocation_id = aws_eip.po-natgw-eip-3.id
  tags = {
    Name = "PO-Nat-Gateway-3"
  }
}
resource "aws_eip" "po-natgw-eip-1" {
  vpc = true
}
resource "aws_eip" "po-natgw-eip-2" {
  vpc = true
}
resource "aws_eip" "po-natgw-eip-3" {
  vpc = true
}
*/